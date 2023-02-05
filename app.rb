
require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/item'
require_relative 'lib/order'

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
    @io.puts "\nWelcome to the shop manager!"
    @io.puts ""
    @io.puts "1 - List all shop items"
    @io.puts "2 - Find info on a specific item"
    @io.puts "3 - Create a new item"
    @io.puts "4 - List all orders"
    @io.puts "5 - Find info on a specific order"
    @io.puts "6 - Create a new order"
    @io.puts "7 - Quit"


    choice = @io.gets.chomp

    if choice == '1'
      list_items
      sleep(4)
      self.run
    elsif choice == '2'
      find_item_info
      sleep(3)
      self.run
    elsif choice == '3'
      create_item
      sleep(2)
      self.run
    elsif choice == '4'
      list_orders
      sleep(4)
      self.run
    elsif choice == '5'
      find_order_info
      sleep(4)
      self.run
    elsif choice == '6'
      create_order
      sleep(2)
      self.run
    elsif choice == '7'
      exit
    else
      @io.puts "\nPlease choose a valid number."
      sleep(1.5)
      self.run
    end
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  def list_items
    @io.puts ""
    @io.puts "Here is the list of shop items:"
    @item_repository.all.each{
      |item|
      puts "#{item.id}. #{item.item_name}"
    }
  end

  def find_item_info
    @io.puts ""
    @io.puts "Please enter the ID of the item you are interested in."
    item_id = @io.gets.chomp
    item = @item_repository.find(item_id)
    @io.puts "Name: #{item.item_name}"
    @io.puts "Unit Price: #{item.unit_price}"
    @io.puts "In Stock: #{item.quantity}"
  end

  def create_item
    
    @io.puts "What is the name of your item?"
    item_name = @io.gets.chomp
    @io.puts "How much does each #{item_name} cost?"
    unit_price = @io.gets.chomp
    @io.puts "How much #{item_name} is in stock currently?"
    quantity = @io.gets.chomp

    new_item = Item.new
    new_item.item_name = item_name
    new_item.unit_price = unit_price
    new_item.quantity = quantity
    
    @item_repository.create(new_item)
    @io.puts "Item successfully created."
  end

  def list_orders
    @io.puts ""
    @io.puts "Here is the list of all orders:"
    @order_repository.all.each{
      |order|
      puts "#{order.id}. Made on #{order.order_date} by #{order.customer_name}"
    }
  end

  def find_order_info
    @io.puts ""
    @io.puts "Please enter the ID of the order you are interested in."
    order_id = @io.gets.chomp
    order = @order_repository.view_order(order_id)
    @io.puts ""
    @io.puts "Order Details:"
    @io.puts "Order made by #{order[0].customer_name} on #{order[0].order_date}."
    @io.puts "\nItems ordered:"
    order[1].each {
      |ordered_item|
      @io.puts "• #{ordered_item.order_quantity} #{ordered_item.item_name} - RM#{ordered_item.price}"
    }
    @io.puts "\nTotal Price: RM#{order[2]}"
  end

  def create_order
    @io.puts "\nWhat is the customer's name?"
    customer_name = @io.gets.chomp
    @io.puts "When was the date of the order?"
    order_date = @io.gets.chomp

    item_ids = []
    item_quantities = []

    @io.puts "Please type the ID of an item that was ordered:"

    while true
      item_id = @io.gets.chomp
      @io.puts "How many units of this item would you like to order?"
      item_quantity = @io.gets.chomp
      item_ids.push(item_id)
      item_quantities.push(item_quantity)

      @io.puts "Would you like to add more items to this order?"
      answer = @io.gets.chomp 

      yesses = ['Yes','yes','yea','yeah','Yea','Yeah','ya','Ya']
      if !yesses.include?(answer)
        break
      else
        @io.puts "Please type the ID of another item:"
      end
    end

    order_details = Order.new
    order_details.customer_name = customer_name
    order_details.order_date = order_date

    @order_repository.create(order_details, item_ids, item_quantities)
    @io.puts "Order successfully created."
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end