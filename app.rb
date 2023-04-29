require_relative './lib/item_repository'
require_relative './lib/order_repository'
require 'date'

class Application

  attr_reader :menu_string

  def initialize(io = Kernel, date_class = Date)
    @io = io
    @date_class = date_class
    @methods = [method(:list_all_shop_items),
                method(:create_an_item),
                method(:list_all_orders),
                method(:create_an_order),
                method(:add_item_to_order)]
    @menu_string = build_menu_string
  end

  def run
    result = nil
    while result != 'quit'
      result = user_input
    end
  end

  def user_input
    @io.puts @menu_string
    
    method = @io.gets.chomp 
    return 'quit' if method == 'quit' || method == 'close'
    @methods[method.to_i - 1].call
  end

  def list_all_shop_items
    items = ItemRepository.new.list
    for item in items do
      @io.puts "Item id: #{item.id} - Item: #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_an_item
    @io.puts "Please enter the name of the item to add:"
    name = @io.gets.chomp
    @io.puts "Please enter the price of the item:"
    price = @io.gets.chomp
    @io.puts "Please enter the quantity of the item:"
    quantity = @io.gets.chomp

    item = Item.new(name, price, quantity)

    id = ItemRepository.new.create(item)
    item.id = id

    @io.puts "Item id: #{id} - Item: #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity} added"
  end

  def list_all_orders
    orders = OrderRepository.new.list
    for order in orders do
      @io.puts "Order id: #{order.id} - Customer name: #{order.customer_name} - Order date: #{order.date}"
    end
  end

  def create_an_order
    @io.puts "Please enter the customer name:"
    name = @io.gets.chomp
    date = @date_class.today.to_s

    order = Order.new(name, date)

    id = OrderRepository.new.create(order)
    @io.puts "Order id: #{id} - Customer name: #{name} - Order date: #{date} added"
  end

  def add_item_to_order
    @io.puts "Please enter the order id:"
    order_id = @io.gets.chomp.to_i
    @io.puts "Please enter the item id:"
    item_id = @io.gets.chomp.to_i

    order_repo = OrderRepository.new
    item_repo = ItemRepository.new

    order_repo.assign_item(order_id, item_id)

    item = ItemRepository.new.find_by_id(item_id)
    order = OrderRepository.new.find_by_id(item_id)
    @io.puts "#{item.name} have been added to #{order.customer_name}'s order"
  end

  private 
  
  def build_menu_string
    string = "What would you like to do?\n"
    string << "\t1 -> List all shop items\n"
    string << "\t2 -> Create a new item\n"
    string << "\t3 -> List all orders\n"
    string << "\t4 -> Create a new order \n"
    string << "\t5 -> Add items to order"
  end
end

if __FILE__ == $0
  DatabaseConnection.connect('stock_control')
  app = Application.new(Kernel)
  app.run
end
