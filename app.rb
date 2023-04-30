# file: app.rb
require_relative 'lib/database_connection'
require_relative './lib/items_repository'
require_relative './lib/orders_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, items_repository, orders_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

def run
  @io.puts "Welcome to the shop management program!"
  @io.puts ""
  @io.puts "What would you like to do?"
  @io.puts "1 - List all shop items"
  @io.puts "2 - Create a new item"
  @io.puts "3 - List all orders"
  @io.puts "4 - Create a new order"
  input = @io.gets.to_i

  case input
  when 1
    all_items = @items_repository.all
    puts "Here is a list of your shop items!"
    puts ""
    all_items.each do |item|
      puts "##{item.item_name} - Unit price: #{item.item_price} - Quantity: #{item.item_quantity}"
    end
  when 2 
    @io.puts "Please enter the name of the item"
    new_name = @io.gets.chomp.to_s
    @io.puts "Please enter the price of the item"
    new_unit_price = @io.gets.chomp.to_i
    @io.puts "Please enter the quantity of the item"
    new_stock_quantity = @io.gets.chomp.to_i
    @io.puts "Here's a list of all shop items:"
    new_item = Items.new
    new_item.item_name, new_item.item_price, new_item.item_quantity = new_name, new_unit_price, new_stock_quantity
    @items_repository.create(new_item)
    @items_repository.all.each do |item|
      @io.puts "##{item.item_name} - Unit price: #{item.item_price} - Quantity: #{item.item_quantity}"
    end
  when 3
    @io.puts "Here's a list of all orders:"
    @orders_repository.all.each do |order|
      @io.puts "##{order.order_name} Customer: #{order.customer_name} - Order date: #{order.order_date}"
    end
  when 4 
    @io.puts "Please enter the name of the order"
    new_name = @io.gets.chomp.to_s
    @io.puts "Please enter the name of the customer"
    new_customer = @io.gets.chomp.to_s
    @io.puts "Please enter date of the order"
    new_date = @io.gets.chomp.to_i
    @io.puts "Here's a list of all shop orders:"
    new_order = Orders.new
    new_order.order_name, new_order.customer_name, new_order.order_date = new_name, new_customer, new_date
    @orders_repository.create(new_order)
    @orders_repository.all.each do |order|
      @io.puts "##{order.order_name} - Customer Name: #{order.customer_name} - Order Date: #{order.order_date}"
      end
    end
  end
end



# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_database',
    Kernel,
    ItemsRepository.new,
    OrdersRepository.new
  )
  app.run
end