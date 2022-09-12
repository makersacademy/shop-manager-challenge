require_relative './item'
require_relative './item_repository'
require_relative './order'
require_relative './order_repository'
require_relative './database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def print_all_items
    result = @item_repository.all_items
    result.each do |item|
      @io.puts "##{item.id} - #{item.name} - Price: #{item.price} - Stock quantiy: #{item.stock_qty}"
    end
  end

  def create_new_item
    item = Item.new
    
    @io.puts "Enter item name:"
    item.name = @io.gets.chomp
    @io.puts "Enter item price:"
    item.price = @io.gets.chomp
    @io.puts "Enter item stock quantity:"
    item.stock_qty = @io.gets.chomp

    @item_repository.create_item(item)
    @io.puts "Item created."    
  end

  def print_all_orders
    result = @order_repository.all_orders
    result.each do |order|
      @io.puts "##{order.id} - Customer: #{order.customer} - Item: #{order.item} - Order date: #{order.date}"
    end
  end

  def create_new_order
    order = Order.new

    @io.puts "Enter customer name:"
    order.customer = @io.gets.chomp
    @io.puts "Enter item name:"
    order.item = @io.gets.chomp
    @io.puts "Enter order date:"
    order.date = @io.gets.chomp

    @order_repository.create_order(order)
    @io.puts "Order created."    
  end

  def run
    @io.puts "Welcome to the Makers (August 2022 Cohort) shop manager!"
    @io.puts "What would you like to do?"
    @io.puts "1 - List all shop items"
    @io.puts "2 - Create a new item"
    @io.puts "3 - List all orders"
    @io.puts "4 - Create a new order"

    @io.puts "Enter your choice:"    
    input = @io.gets.chomp        
    if input == "1"
      print_all_items
    elsif input == "2"
      create_new_item
    elsif input == "3"
      print_all_orders
    elsif input == "4"
      create_new_order
    end
  end

end