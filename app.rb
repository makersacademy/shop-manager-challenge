# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

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
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
    welcome_message
    present_menu
    handle_choice
    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  private

  def welcome_message
    @io.puts("Welcome to the shop management program!")
    @io.puts("")
  end

  def present_menu
    @io.puts("What do you want to do?")
    @io.puts("  1 - list all shop items")
    @io.puts("  2 - create a new item")
    @io.puts("  3 - list all orders")
    @io.puts("  4 - create a new order")
    @io.puts("")
  end

  def handle_choice
    choice = @io.gets.chomp
    case choice
    when "1"
      display_items
    when "2"
      create_item_dialogue
    when "3"
      display_orders
    when "4"
      create_order_dialogue
    else
      # fail
      fail "Must choose one of the available options"
    end
  end

  def display_items
    @io.puts("Here's a list of all shop items:")

    @item_repository.all.each do |item|
      @io.puts(" ##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}")
    end

  end

  def display_orders

    @io.puts("Here's a list of all shop orders:")
    @order_repository.all.each do |order|
      item_name = @item_repository.find(order.item_id).name
      @io.puts(" ##{order.id} #{order.customer_name} - Ordered: #{item_name} - On: #{order.date}")
    end

  end

  def create_item_dialogue

    item = Item.new
    @io.puts("Please enter the new item name:")
    item.name = @io.gets.chomp
    @io.puts("Please enter the unit price to the nearest pound:")
    item.unit_price = @io.gets.chomp
    @io.puts("Please enter stocked quantity:")
    item.quantity = @io.gets.chomp
    @item_repository.create(item)
    @io.puts("##{@item_repository.all.last.id} #{item.name} added to system with a quantity of #{item.quantity} and a price of £#{item.unit_price}")
  end

  def create_order_dialogue
    order = Order.new
    @io.puts("Please enter the customer name:")
    order.customer_name = @io.gets.chomp
    @io.puts("Please enter the date in format YYYY-MM-DD:")
    order.date = @io.gets.chomp
    @io.puts("Please enter the item id:")
    order.item_id = @io.gets.chomp
    @order_repository.create(order)
    @io.puts("##{@order_repository.all.last.id} #{@item_repository.find(order.item_id).name} ordered for #{order.customer_name} on #{order.date}")

  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
# if __FILE__ == $0
#   app = Application.new(
#     'shop_manager',
#     Kernel,
#     ItemRepository.new,
#     OrderRepository.new
#   )
#   app.run
# end
