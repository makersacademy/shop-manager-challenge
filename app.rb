# file: app.rb
require_relative './lib/item_repository'
require_relative './lib/order_repository.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager_test')

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts "What do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = create a new item"
    @io.puts " 3 = list all orders"
    @io.puts " 4 = create a new order"
    input = @io.gets.chomp 
    case  
    when input == "1"
      @io.puts "Here's a list of all shop items:"
      list = @item_repository.all.sort_by(&:id)
      list.each do |item|
        @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    when input == "2"
      repo = ItemRepository.new
      item = Item.new
      @io.puts 'Please enter the item name:'
      item.name = @io.gets.chomp
      @io.puts 'Please enter the unit price:'
      item.unit_price = @io.gets.chomp
      @io.puts 'Please enter the quantity:'
      item.quantity = @io.gets.chomp
      repo.create(item)
      
      @io.puts "New item created"
      # new_item = @item_repository.all.last
      # puts new_item.name
    when input == "3"
      @io.puts "Here's a list of all shop orders:"
      list = @order_repository.all.sort_by(&:id)
      list.each do |order|
        @io.puts " ##{order.id} #{order.customer_name} - Order date: #{order.order_date}"
      end
    when input == "4"
      repo = OrderRepository.new
      order = Order.new
      @io.puts 'Please enter the customer name:'
      order.customer_name = @io.gets.chomp
      @io.puts 'Please enter the order date:'
      order.order_date = @io.gets.chomp
      repo.create(order)
      
      @io.puts "New order created"
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end