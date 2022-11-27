require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/item'
require_relative 'lib/order'

class Application

  # The Application class initializer takes four arguments:
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
    # "Runs" the terminal application so it can ask the user to enter some input
    # and then decide to run the appropriate action or behaviour.

    # Use `@io.puts` or `@io.gets` to write output and ask for user input.

    @io.puts "Welcome to the shop management program!\n"

    @io.puts "What do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = create a new item"
    @io.puts " 3 = list all orders"
    @io.puts " 4 = create a new order\n"
    
    command = @io.gets.chomp

    if command == "1"
      @io.puts "\nHere's a list of all shop items:\n"
      items = @item_repository.all
      items.each do |item|
        @io.puts " ##{item.id} #{item.name} - unit price: £#{item.unit_price} - quantity remaining: #{item.quantity}"
      end
    elsif command == "2"
      item = Item.new
      @io.puts "Please enter the following item information:"
      @io.puts "Item name: "
      item.name = @io.gets.chomp
      @io.puts "Unit price: "
      item.unit_price = @io.gets.chomp
      @io.puts "Quantity remaining: "
      item.quantity = @io.gets.chomp
      # Add item to repo
      @item_repository.create(item)
      @io.puts "This item has been successfully added"
    elsif command == "3"      
      @io.puts "\nHere's a list of all orders:\n"
      orders = @order_repository.all
      orders.each do |order|
        @io.puts " ##{order.id} Customer: #{order.customer_name} - item id: #{order.item_id} - date order was placed: #{order.date}"
      end
    elsif command == "4"
      order = Order.new
      @io.puts "Please enter the following order information:" 
      @io.puts "Customer name: "
      order.customer_name = @io.gets.chomp
      @io.puts "Item id: "
      order.item_id = @io.gets.chomp
      @io.puts "Date of order (YYYY-MM-DD): "
      order.date = @io.gets.chomp
      # Add order to repo
      @order_repository.create(order)
      @io.puts "This order has been successfully added"
    else
      @io.puts "Only 1, 2, 3 and 4 are valid commands"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'items_orders',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end