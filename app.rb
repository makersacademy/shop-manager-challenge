require_relative 'lib/database_connection'
require_relative 'lib/orders_repository.rb'
require_relative 'lib/items_repository.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

# Perform a SQL query on the database and get the result set.


# Print out each record from the result set .
# result.each do |record|
#   p record
# end
class Management
  def initialize(io)
    @io = io
    @new_item = Item.new
    @new_order = Order.new
  end

  def run
    puts 'Welcome to the shop management program!'
    puts "\nWhat to you want to do? \n  1 - List all shop items \n  2 - Create a new item
  3 - List all orders \n  4 - Create a new order"
    user_input = @io.gets.chomp
    case user_input
      when "1"
        list_items()
      when "2"
        create_item(@new_item)
      when "3"
        list_orders()
      when "4"
        create_order(@new_order)
    end
  end

  def list_items
    sql = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    puts "Here's a list of all shop items:"
    result.each do |record|
      @io.puts "##{record['id']} #{record['item_name']} - Unit price: #{record['price']} - Quantity: #{record['quantity']}"
    end
  end

  def create_item(new_item)
    new_item = Item.new
    puts "What's the item id?"
    new_item.id = @io.gets.chomp
    puts "What's the item name?"
    new_item.item_name = @io.gets.chomp
    puts "What's the price?"
    new_item.price = @io.gets.chomp
    puts "What's the quantity?"
    new_item.quantity = @io.gets.chomp

    sql = 'INSERT INTO items (id, item_name, price, quantity) VALUES($1, $2, $3, $4);'
    param = [new_item.id, new_item.item_name, new_item.price, new_item.quantity]
    result_set = DatabaseConnection.exec_params(sql, param)
    return nil
  end

  def list_orders
    sql = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])
    puts "Here's a list of all orders:"
    result.each do |record|
      @io.puts "##{record['id']} Customer: #{record['customer_name']} - Date: #{record['date']}"
    end
  end

  def create_order(new_order)
    new_order = Order.new
    puts "What's the order id?"
    new_order.id = @io.gets.chomp
    puts "What's the customer name?"
    new_order.customer_name = @io.gets.chomp
    puts "What's the date the order was placed?"
    new_order.date = @io.gets.chomp

    sql = 'INSERT INTO orders (id, customer_name, date) VALUES($1, $2, $3);'
    param = [new_order.id, new_order.customer_name, new_order.date]
    result_set = DatabaseConnection.exec_params(sql, param)
    return nil
  end
end

management = Management.new(Kernel)
OrdersRepository.new
ItemsRepository.new
@new_item = Item.new
management.run