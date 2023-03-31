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
    # loop do
    #   print_menu
    #   selection(@io.gets.chomp)
    # end
  end

  # Takes the user's selection and perfoms the appropriate action
  def do_selection(selection)
    case selection
    when "1"
      print_items
    when "2"
      print_items_by_order
    when "3"
      create_item
    when "4"
      print_orders
    when "5"
      print_orders_by_item
    when "6"
      create_order
    when "7"
      @io.exit
    end
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
    @io.puts "7 - Exit"
  end

  # prints all the items
  def print_items
    @io.puts "All items:"
    @item_repository.all.each do |item|
      print_item(item)
    end
  end

  # prints all the items attached to an order
  def print_items_by_order
    @io.puts "What order do you want to see the items for?"
    order_id = @io.gets.chomp.to_i
    @item_repository.find_by_order(order_id).each do |item|
      print_item(item)
    end
  end

  # creates an item
  def create_item
    item = Item.new
    @io.print "Name: "
    item.name = @io.gets.chomp
    @io.print "Price: "
    item.unit_price = @io.gets.chomp.to_f
    @io.print "Quantity: "
    item.quantity = @io.gets.chomp.to_i
    @item_repository.create(item)
    @io.puts("Item created!")
  end

  # prints all the orders
  def print_orders
    @io.puts "All orders:"
    @order_repository.all.each do |order|
      print_order(order)
    end
  end

  # prints all orders that have an item
  def print_orders_by_item
    @io.puts "What item do you want to see the orders for?"
    item_id = @io.gets.chomp.to_i
    @order_repository.find_by_item(item_id).each do |order|
      print_order(order)
    end
  end

  # creates a new item
  def create_order
    order = Order.new
    @io.print "Name: "
    order.customer_name = @io.gets.chomp
    @io.print "Date: "
    order.date = @io.gets.chomp

    @order_repository.create(order)
    @io.puts "Order created!"
  end

  def print_item(item)
    @io.puts "#{item.name} - Price: £#{sprintf('%.2f',item.unit_price)} - Quantity: #{item.quantity}"
  end

  def print_order(order)
    @io.puts "#{order.customer_name} - #{order.date}"
  end

  def exit_prog

  end
end