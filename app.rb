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
  def initialize(shop_manager, io, order_repository, item_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def all_items
    @io.puts "Here's a list of all shop items:
    "
    @item_repository.all.each do |item|
      @io.puts "##{item.id} - Name: #{item.name} - Unite price: £#{item.price} - Quantity: #{item.quantity}"
    end 
  end

  def all_orders
    @io.puts "Here's a list of all orders:
    "
    @order_repository.all.each do |order|
      @io.puts "##{order.id} - Customer: #{order.customer} - Order date: #{order.date} - Item id: #{order.item_id}"
    end
  end

  def create_item
    new_item = Item.new
    @io.puts "Enter the id of the item: "
    new_item.id = @io.gets.chomp
    @io.puts "Enter the name of the item: "
    new_item.name = @io.gets.chomp
    @io.puts "Enter the price of the item: "
    new_item.price = @io.gets.chomp.to_f
    @io.puts "Enter quantity: "
    new_item.quantity = @io.gets.chomp.to_i
    
    @item_repository.create(new_item)
    @io.puts "Your item was successfully added!"
  end

  def create_order
    new_order = Order.new
    @io.puts "Enter the id of the order: "
    new_order.id = @io.gets.chomp
    @io.puts "Enter the name of the customer: "
    new_order.customer = @io.gets.chomp
    @io.puts "Enter the date of the order: "
    new_order.date = @io.gets.chomp

    @order_repository.create(new_order)
    @io.puts "Your order was successfully added!"
  end

  def run
    @io.puts "Welcome to the shop management program!
    "
    @io.puts "What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order
    "
    @io.puts"Enter your choice: "
    answer = @io.gets.chomp

    case answer
      when "1"
        all_items
      when "2"
        create_item
      when "3"
        all_orders
      when "4"
        create_order
    end
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
  end
end

# If we run this file using `ruby app.rb`,
# run the app.
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new,
  )
  app.run
end