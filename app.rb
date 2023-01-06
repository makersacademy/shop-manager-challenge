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

  private

  def list_shop_items
    @io.puts "Here is the list of all shop items:"
    item_repository = ItemRepository.new
    counter = 1
    item_repository.all.each do |item|
      @io.puts "##{counter} - #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
      counter += 1
    end
  end
  
  def list_orders
    @io.puts "Here is the list of all orders:"
    order_repository = OrderRepository.new
    counter = 1
    order_repository.all.each do |order|
      @io.puts "##{counter} - Customer name: #{order.customer_name} - Order date: #{order.date} - Item ID: #{order.item_id}"
      counter += 1
    end
  end

  def add_new_item
    @io.puts "What is the name of the new item? "
    item_name = @io.gets.chomp
    @io.puts "What is the price of '#{item_name}'? "
    item_price = @io.gets.chomp
    @io.puts "What is the quantity of '#{item_name}'? "
    item_quantity = @io.gets.chomp
    
    item_repository = ItemRepository.new
    item = Item.new
    item.name = item_name
    item.price = item_price
    item.quantity = item_quantity
    item_repository.create(item)

    @io.puts "Added '#{item_name} - Unit price: #{item_price} - Quantity: #{item_quantity}' to items"
  end

  def create_order
    @io.puts "What is the customer's name? "
    customer_name = @io.gets.chomp
    @io.puts "What is the item ID that '#{customer_name}' wishes to order? "
    item_id = @io.gets.chomp

    order_repository = OrderRepository.new
    item_repository = ItemRepository.new
    order = Order.new
    order.customer_name = customer_name
    order.date = Date.today
    order.item_id = item_id
    order_repository.create(order)
    item = item_repository.find(item_id)

    @io.puts "Order added! - 'Customer Name: #{customer_name} - Date: #{Date.today} - Item: #{item.name}'"
  end

  public

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat would you like to do?\n 1 - List all shop items\n 2 - create a new item\n 3 - list all orders\n 4 - create a new order"
    @io.puts "\nEnter your choice: "
    user_choice = @io.gets.chomp

    case user_choice
    when '1' then list_shop_items
    when '2' then add_new_item
    when '3' then list_orders
    when '4' then create_order
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager_database',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
