require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require 'date'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_intro
    loop do
      print_menu
      process(@io.gets.chomp)
      break # <-- uncomment this break to have the menu reprint so multiple operations
      # can be carried out e.g. list all items then make an order then list orders
    end
  end

  def process(selection)
    case selection
    when '1' then list_items
    when '2' then create_item
    when '3' then list_orders
    when '4' then create_order
    when '9' then exit
    end
  end

  def print_intro
    @io.puts "Welcome to the shop management program!\n"
    @io.puts 'What would you like to do?'
  end

  def print_menu
    @io.puts ' 1 - List all shop items'
    @io.puts ' 2 - Create a new item'
    @io.puts ' 3 - List all orders'
    @io.puts ' 4 - Create a new order'
    @io.puts ' 9 - Exit'
  end

  def list_items
    all_items = @item_repository.all
    all_items.each do |item|
      @io.puts "#{item.id} - #{item.name} - £#{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def list_orders
    all_orders = @order_repository.all
    all_orders.each do |order|
      @io.puts "#{order.id} - Name: #{order.customer_name} - Date: #{order.date_placed} - Items: #{order.items.join(', ')}"
    end
  end

  def create_order
    order_info = new_order_info
    order = Order.new
    order.customer_name, quantity, item_id = order_info
    order.date_placed = Date.today.to_s
    @order_repository.create(order,quantity,item_id)
  end

  def new_order_info
    @io.puts "What would you like to order?"
    name = @io.gets.chomp
    item_id = look_up_item_id(name)
    @io.puts "How many would you like?"
    quantity = @io.gets.chomp.to_i
    @io.puts "Please enter your name"
    customer_name = @io.gets.chomp
    [customer_name,quantity,item_id]
  end

  def look_up_item_id(name)
    sql = 'SELECT items.id FROM items WHERE items.name = $1'
    params = [name]
    result = DatabaseConnection.exec_params(sql,params)
    result[0]['id']
  end

  def create_item
    item_info = new_item_info
    item = Item.new
    item.name, item.unit_price, item.quantity = item_info
    @item_repository.create(item)
  end

  def new_item_info
    @io.puts "What is the name of the item?"
    name = @io.gets.chomp
    @io.puts "Please enter the unit price"
    unit_price =  @io.gets.chomp
    @io.puts "How many do you have in stock?"
    quantity = @io.gets.chomp
    [name,unit_price,quantity]
  end
end

if __FILE__ == $0
  app = Application.new(
    'orders_items_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
