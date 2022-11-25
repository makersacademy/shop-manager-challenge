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
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run

    @io.puts "\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n"
    @io.puts "Type your answer here:"
    user_input = @io.gets.chomp

    #  list all the items
    if user_input == "1"
      items_list = @item_repository.list
      puts items_list
    end

    #  create a new item
    if user_input == "2"
      # get all the fields needed from the user
      @io.puts "Please provide the item's name:"
      item_name = @io.gets.chomp
      @io.puts "Please provide the item's unit price:"
      unit_price = @io.gets.chomp
      @io.puts "Please provide the item's quantity:"
      quantity = @io.gets.chomp
      # assign these fields/variables to the object
      new_item = Item.new
      new_item.name = item_name
      new_item.unit_price = unit_price
      new_item.quantity = quantity
      #
      @item_repository.create(new_item)
      items_list = @item_repository.list
      puts items_list
    end

    #  list all orders
    if user_input == "3"
      orders_list = @order_repository.list
      puts orders_list
    end

    #  create a new order
    if user_input == "4"
      @io.puts "Please provide your name:"
      customer_name = @io.gets.chomp
      @io.puts "Please provide the order date formatted as Jan-01-2022"
      order_date = @io.gets.chomp
      new_order = Order.new
      new_order.customer_name = customer_name
      new_order.date = order_date
      @order_repository.create(new_order)
    end

  end

end




# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_challenge',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end
