require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'
require 'date'

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
    print_menu
    input = @io.gets.strip
    case input
    when "1"
      print_items
    when "2"
      add_item
    when "3"
      print_orders
    when "4"
      add_order
    end
  end

  def print_menu
    @io.puts "Welcome to the shop management app!"
    @io.puts "\nWhat would you like to do?"
    @io.puts "1 - List all shop items"
    @io.puts "2 - Create a new item"
    @io.puts "3 - List all orders"
    @io.puts "4 - Create a new order"
    @io.print "\nEnter your choice: "
  end

  def print_items
    @io.puts "\nHere is the list of all shop items:"
    items = @item_repository.all
    items.each do |item|
      @io.puts "#{item.id} - #{item.name}, unit price: £#{item.unit_price}.00, quantity available: #{item.quantity}"
    end
  end

  def add_item
    @io.print "\nEnter the name of the new item: "
    item_name = @io.gets.strip
    @io.print "\nEnter the price of the new item in pounds: £"
    item_price = @io.gets.strip
    @io.print "\nHow many of these items have we got in stock?"
    item_quantity = @io.gets.strip
    new_item = Item.new
    new_item.name = item_name
    new_item.unit_price = item_price
    new_item.quantity = item_quantity
    @item_repository.create(new_item)
    @io.puts "\nNew item created successfully."
  end

  def print_orders
    @io.puts "\nHere is the list of all orders:"
    orders = @order_repository.all
    orders.each do |order|
      @io.print "#{order.id} - Customer: #{order.customer_name}, Date placed: #{order.date_placed}, Items ordered: "
      order.items.each_with_index do |item, index|
        @io.print "#{item.name}"
        if order.items.length > index + 1
          @io.print ", "
        else
          @io.print "\n"
        end
      end
    end
  end

  def add_order
    @io.print "\nEnter the name of the customer: "
    customer_name = @io.gets.strip
    order = Order.new
    order.customer_name = customer_name
    time = Time.new
    order.date_placed = time.strftime('%Y-%m-%d')
    more_items = true
    while more_items do
      @io.print "\nEnter an item the customer ordered: "
      item_name = @io.gets.strip  
      # TODO add check if item actually exists!
      item = Item.new
      item.name = item_name
      order.items << item
      @io.print "\nDid the customer order any more items (Yes/No): "
      input = @io.gets.strip.downcase
      if input == "no" || input == "n"
        more_items = false
      end
    end
    @order_repository.create(order)
    @io.puts "The order was created successfully."
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