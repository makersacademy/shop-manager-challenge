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

  # "Runs" the terminal application
  def run
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
  def print_items_by_order
  end

  # creates an item
  def create_item
  end

  # prints all the orders
  def print_orders
  end

  # prints all orders that have an item
  def print_orders_by_item
  end

  # creates a new item
  def print_items
  end
end