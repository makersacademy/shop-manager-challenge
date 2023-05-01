require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

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

    welcome = "Welcome to the shop management program!\n\n"

    menu =  "What do you want to do?\n" \
            "  1 = list all shop items\n" \
            "  2 = create a new item\n" \
            "  3 = list all orders\n" \
            "  4 = create a new order\n" \
            "  9 = exit\n\n"
    
    @io.puts welcome
    @io.puts menu
    
    user_input = @io.gets.chomp

    case user_input
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order
    when "9"
      exit
    else
      @io.puts "Please input 1, 2, 3, 4 or 9"
    end
  end

  def list_items
    @io.puts "\nHere's a list of all shop items:\n\n"

      items = @item_repository.all

      items.each do |item|
        @io.puts "  #{item.id}. #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}" 
      end
  end

  def create_item
    @io.puts "Enter the name of the new item:"
      item_name = @io.gets.chomp

      @io.puts "Enter the unit price of the new item:"
      item_unit_price = @io.gets.chomp.to_i

      @io.puts "Enter the quantity of the new item:"
      item_quantity = @io.gets.chomp.to_i

      item = Item.new

      item.name = item_name
      item.unit_price = item_unit_price
      item.quantity = item_quantity

      @item_repository.create(item)

      @io.puts "New item created!"
  end

  def list_orders
    @io.puts "\nHere's a list of all orders:\n\n"

      orders = @order_repository.all

      orders.each do |order|
        @io.puts "  #{order.id}. Customer name: #{order.customer_name} - Date: #{order.date} - Item ID: #{order.item_id}" 
      end
  end
  
  def create_order
    @io.puts "Enter the customer name for the new order:"
    order_customer_name = @io.gets.chomp

    @io.puts "Enter the date for the new order (YYYY-MM-DD):"
    order_date = @io.gets.chomp

    @io.puts "Enter the new order's item ID:"
    order_item_id = @io.gets.chomp.to_i

    order = Order.new

    order.customer_name = order_customer_name
    order.date = order_date
    order.item_id = order_item_id

    @order_repository.create(order)

    @io.puts "New order created!"
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
