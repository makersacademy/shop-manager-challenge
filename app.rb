require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(shop_manager, io, order_repository, item_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def all_items
    num = 1
    @io.puts "Here's a list of all shop items:
    "
    @item_repository.all.each do |item|
      @io.puts "##{num} - Name: #{item.name} - Unite price: £#{item.price} - Quantity: #{item.quantity}"
      num += 1
    end 
  end

  def all_orders
    num = 1
    @io.puts "Here's a list of all orders:
    "
    @order_repository.all.each do |order|
      @io.puts "##{num} - Customer: #{order.customer} - Order date: #{order.date} - Item id: #{order.item_id}"
      num += 1
    end
  end

  def create_item
    @io.puts "Enter the id of the item: "
    id = @io.gets.chomp
    @io.puts "Enter the name of the item: "
    name = @io.gets.chomp
    @io.puts "Enter the price of the item: "
    price = @io.gets.chomp.to_f
    @io.puts "Enter quantity: "
    quantity = @io.gets.chomp.to_i

    new_item = Item.new
    new_item.id = id
    new_item.name = name
    new_item.price = price
    new_item.quantity = quantity
    @item_repository.create(new_item)
  end

  def create_order
    @io.puts "Enter the id of the order: "
    id = @io.gets.chomp
    @io.puts "Enter the name of the customer: "
    customer = @io.gets.chomp
    @io.puts "Enter the date of the order: "
    date = @io.gets.chomp

    new_order = Order.new
    new_order.id = id
    new_order.customer = customer
    new_order.date = date
    @order_repository.create(new_order)
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
        @io.puts "Your item was successfully added!"

        all_items

      when "3"
        all_orders

      when "4"
        create_order
        @io.puts "Your order was successfully added!"

        all_orders
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