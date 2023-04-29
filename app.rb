require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
  def initialize(io = Kernel.new, date_class = Date)
    @io = io
    @date_class = date_class
    @methods = [method(:list_all_shop_items),
                method(:create_an_item),
                method(:list_all_orders),
                method(:create_an_order),
                method(:add_item_to_order)]
  end

  def run
    user_input
  end

  def user_input
    @io.puts "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
    
    method = @io.gets.chomp.to_i
    @methods[method - 1].call
  end

  def list_all_shop_items
    items = ItemRepository.new.list
    for item in items do
      @io.puts "Item id: #{item.id} - Item: #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_an_item
    p "created items"
    @io.puts "Please enter the name of the item to add:"
    name = @io.gets.chomp
    @io.puts "Please enter the price of the item:"
    price = @io.gets.chomp
    @io.puts "Please enter the quantity of the item:"
    quantity = @io.gets.chomp

    item = Item.new
    item.name = name
    item.unit_price = price
    item.quantity = quantity

    id = ItemRepository.new.create(item)
    @io.puts "Item id: #{id} - Item: #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity} added"
  end

  def list_all_orders
    # TODO order repo spec to be done
    p "listed orders"
    orders = OrderRepository.new.list
    for order in orders do
      @io.puts "Order id: #{order.id} - Customer name: #{order.customer_name} - Order date: #{order.date}"
    end
  end

  def create_an_order
    @io.puts "Please enter the customer name:"
    name = @io.gets.chomp
    date = @date_class.today.to_s

    order = Order.new
    order.customer_name = name
    order.date = date

    id = OrderRepository.new.create(order)
    @io.puts "Order id: #{id} - Customer name: #{name} - Order date: #{date} added"
  end

  def add_item_to_order
  end
end
