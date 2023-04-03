# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the OrderRepository object (or a double of it)
  #  * the ItemRepository object (or a double of it)
  def initialize(database_name, io, order_repository, item_repository, current_date)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
    @current_date = current_date
    DatabaseConnection.connect(database_name)
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "5 = exit"

    while true
  
      choice = @io.gets.chomp 
  
      if choice == "1"
        list_items_flow()
        
      elsif choice == "2"
        create_item_flow()

      elsif choice == "3"
        list_order_flow()

      elsif choice == "4"
        create_order_flow()

      elsif choice == "5"
        break
      end
    end
  end

  def list_items_flow

    @io.puts "Here's a list of all shop items:\n\n"
    items = @item_repository.all
    #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30

    items.each do |item|
      @io.puts "#{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
    end
  end

  def list_order_flow
    @io.puts "Here is the list of orders:"
    orders = @order_repository.all_with_items
    output_message = ""

    orders.each do |order|
      output_message.concat("Order: #{order} \n")
      output_message.concat("Items: \n")
      output_message.concat("#{format_items_to_print(order.items)}\n\n")
    end
    @io.puts output_message
  end

  def create_item_flow
    @io.puts "Type Item name:"
    name = @io.gets.chomp
    @io.puts "Type Unit price:"
    price = @io.gets.chomp
    @io.puts "Type quantity:"
    quantity = @io.gets.chomp
    item = Item.new(nil,name, price, quantity)
    @item_repository.create(item)
    @io.puts "Item #{name} succesfully created."
  end

  def create_order_flow
    @io.puts "Starting your order: Type your name:"
    name = @io.gets.chomp
    order = Order.new(nil, @current_date, name)
    while true
      @io.puts "Type the id of your item or 0 to complete your order:"
      id = @io.gets.chomp.to_i
      if id == 0
        @order_repository.create_with_items(order)
        break 
      end
      
      # It only includes an item when its in stock
      if @item_repository.has_stock(id)
        order.items << Item.new(id)
      else
        @io.puts "This item is sold out"
      end
    end
    @io.puts "#{name}, your order was succesfully placed."
  end

  def format_items_to_print(items)
    items.map { | item |
      "  #{item.id} #{item.name} - Unit price: #{item.price}"
    }.join("\n")
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  d = DateTime.now()
  d = d.strftime("%d/%m/%Y %H:%M")

  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new,
    d
  )
  app.run
end