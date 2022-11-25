require_relative './lib/items_repository'
require_relative './lib/orders_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the OrdersRepository object (or a double of it)
  def initialize(database_name, io, items_repository, orders_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What would you like to do?'
    @io.puts '1 - List all shop items'
    @io.puts '2 - Create a new item'
    @io.puts '3 - List all shop orders'
    @io.puts '4 - Create a new order'
    @io.puts 'Enter your choice:'
    input = @io.gets.chomp
      if input == '1'
        @io.puts 'Here is the list of shop items:'
        @items_repository.all.each do |item|
          @io.puts "##{item.id} #{item.name} - unit price: #{item.price} - quantity: #{item.quantity}"
        end

      elsif input == '2'
          item = Item.new
          items_repository = ItemRepository.new 
          @io.puts 'Enter the item name:'
          item.name = @io.gets.chomp
          @io.puts 'Enter the item unit price:'
          item.price = @io.gets.chomp
          @io.puts 'Enter the item quantity:'
          item.quantity = @io.gets.chomp
          items_repository.create(item)
          @io.puts "Item created"

      elsif input == '3'
        @io.puts 'Here is the list of shop orders:'
        @orders_repository.all.each do |order|
          @io.puts "##{order.id} #{order.name} - date: #{order.date}"
        end
      
      else 
          order = Order.new
          orders_repository = OrdersRepository.new 
          @io.puts 'Enter the order name:'
          order.name = @io.gets.chomp
          @io.puts 'Enter the order date:'
          order.date = @io.gets.chomp
          orders_repository.create(order)
          @io.puts "Order created"
      end
  end 
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrdersRepository.new
  )
  app.run
end