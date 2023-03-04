# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/item'
require_relative './lib/order'
require 'date'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the OrderRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop managment program!"
    loop do
    @io.puts "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order
  5 = Exit program"
    input = @io.gets.chomp
    break if input.empty?
    input_cases(input)
    end
  end

  def input_cases(input)
    case input
    when "1"
      @io.puts format_items_list
    when "2"
      create_new_item
    when "3"
      @io.puts format_orders_list
    when "4"
      create_new_order
    when "5"
      exit
    end
  end

  def format_items_list
    items = @item_repository.all
    format_string_array = ["\n"]
    items.each_with_index do |item, index|
      str = "#{index + 1} - #{item.name} - Price: #{item.price} - Quantity: #{item.quantity}"
      format_string_array << str
    end
    format_string_array << "\n"
  end

  def create_new_item
    item = Item.new
    @io.puts "Please enter the item name:"
    item.name = @io.gets.chomp
    @io.puts "Please enter the item's price:"
    item.price = @io.gets.chomp
    @io.puts "Please enter the item quantity:"
    item.quantity = @io.gets.chomp
    @item_repository.create(item)
  end

  def format_orders_list
    orders = @order_repository.all
    format_string_array = ["\n"]
    orders.each_with_index do |order, index|
      str = "#{index + 1} - Customer: #{order.customer} - Date: #{order.date} - Item: #{get_item_by_id(order.item_id)}"
      format_string_array << str
    end
    format_string_array << "\n"
  end

  def get_item_by_id(id)
    sql = 'SELECT name FROM items WHERE id = $1'
    result = DatabaseConnection.exec_params(sql, [id])
    item_name = result[0]['name']
  end

  def create_new_order
    order = Order.new
    @io.puts "Please enter the customer's name:"
    order.customer = @io.gets.chomp
    order.date = Date.today.strftime('%Y-%m-%d')
    @io.puts "Please enter the ordered item's id:"
    order.item_id = @io.gets.chomp
    @order_repository.create(order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
