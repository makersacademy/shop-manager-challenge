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

    print_menu
    selection = @io.gets.chomp
    case selection
    when "1"
      # print items
    when "2"
      # print items by order
    when "3"
      # creates an item
    when "4"
      # print order
    when "5"
      # print orders with item
    when "6"
      # create an order
    else
      # not valid
    end
  end

  # Takes the user's selection and perfoms the appropriate action
  def do_selection(selection)

  end

  # Prints the menu
  def print_menu
    @io.puts "Welcome to the shop!"
    @io.puts "What would you like to do?"
    @io.puts "1 - List all items"
    @io.puts "2 - List all items attached to an order"
    @io.puts "3 - Create a new item"
    @io.puts "4 - List all orders"
    @io.puts "5 - List all orders that contain a specific item"
    @io.puts "6 - Create a new order"
  end

  # prints all the items
  def print_items
  end

  # prints all the items attached to an order
  # order_id: int - representing the order the user wants to inspect
  def print_items_by_order(order_id)
  end

  # creates an item
  def create_item
  end

  # prints all the orders
  def print_orders
  end

  # prints all orders that have an item
  # item_id: int - representing the item the user wants to view orders containing it
  def print_orders_by_item(item_id)
  end

  # creates a new item
  def print_items
  end
end