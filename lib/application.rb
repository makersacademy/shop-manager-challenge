require_relative '../items/lib/item_repository'
require_relative '../items/lib/item'
require_relative '../orders/lib/order_repository'
require_relative '../orders/lib/order'
require_relative 'database_connection'

class Application
  # The Application class initializer
  # takes four arguments
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
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
    @io.puts "Welcome to the shop management program!"
    menu
  end

  def menu
    @io.puts "What do you want to do?"
    @io.puts "1 - List all shop items"
    @io.puts "2 - Create a new item"
    @io.puts "3 - List all orders"
    @io.puts "4 - Create a new order"
    @io.puts "Enter your choice:"
    choice(@io.gets.chomp)
  end

  def choice(selection)
    if selection == "1"
      @io.puts "Here is the list of items:"
      item_repo = @item_repository.all
      item_repo.each do |item|
        @io.puts "#{item.id} #{item.item_name} - Unit price: £#{item.unit_price} - Quantity: #{item.quantity}"
      end

    elsif selection == "2"
      new_item = Item.new
      @io.puts "Please enter an item name"
      new_item.item_name = @io.gets.chomp
      @io.puts "Please enter a number representing price per unit"
      new_item.unit_price = @io.gets.chomp
      @io.puts "Please enter a number representing number of units"
      new_item.quantity = @io.gets.chomp
      @item_repository.create(new_item)
      @io.puts "Successfully created new item!"

    elsif selection == "3"
      @io.puts "Here is the list of orders:"
      order_repo = @order_repository.all
      order_repo.each do |order|
        @io.puts "#{order.id} #{order.customer_name}- Item ID: #{order.item_id} - Date: #{order.order_date}"
      end

    elsif selection == "4"
      new_order = Order.new
      @io.puts "Please enter a customer name"
      new_order.customer_name = @io.gets.chomp
      @io.puts "Please enter an item ID"
      new_order.item_id = @io.gets.chomp
      @io.puts "Please enter an order date"
      new_order.order_date = @io.gets.chomp
      @order_repository.create(new_order)
      @io.puts "Successfully created new order!"

    else
      @io.puts "Please enter a valid option:"
      menu
    end

  end
end

# The below code is basically saying "only
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