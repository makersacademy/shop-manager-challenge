require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/item'
require_relative 'lib/order'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the ObjectRepository object (or a double of it)
  def initialize(_database_name, io, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager_test_1')
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
    welcome
    choice = @io.gets.chomp
    handle_choice(choice)
  end

  def welcome
    @io.puts "Welcome to the shop management program!"
    @io.puts
    @io.puts "What do you want to do?"
    @io.puts " 1 - list all shop items"
    @io.puts " 2 - create a new item"
    @io.puts " 3 - list all orders"
    @io.puts " 4 - create a new order"
    @io.puts
    @io.puts "Enter your choice: "
  end

  def handle_choice(choice)
    @io.puts
    case choice 
    when '1'
      list_of_items
    when '2'
      create_new_item
    when '3'
      list_of_orders
    when '4'
      create_new_order
    else
      @io.puts "That is not a valid choice."
    end
  end

  def list_of_items
    @item_repository = ItemRepository.new
    items = @item_repository.all
    items.sort_by! { |item| item.id.to_i } 
    items.each do |record| 
      @io.puts "##{record.id} - #{record.item_name} - Unit price: #{record.unit_price} - Quantity: #{record.item_quantity}"
    end
  end

  def create_new_item
    @item_repository = ItemRepository.new
    new_item = Item.new
    @io.puts "What is the item's name?"
    new_item.item_name =  @io.gets.chomp 
    @io.puts "What is the item's price per unit?"
    new_item.unit_price = @io.gets.chomp
    @io.puts "How many #{new_item.item_name} do I have in stock?"
    new_item.item_quantity = @io.gets.chomp 
    @item_repository.create(new_item)
    @io.puts "A new item was created!"
    @io.puts "#{new_item.item_name} - Unit price: #{new_item.unit_price}, Quantity: #{new_item.item_quantity}"
  end

  def create_new_order
    repo = OrderRepository.new
    new_order = Order.new
    @io.puts "What is the customer's name?"
    new_order.customer_name = @io.gets.chomp 
    @io.puts "Which date was the order placed?"
    new_order.order_date = @io.gets.chomp
    @io.puts "What item was ordered (enter intem's code)?"
    new_order.item_id = @io.gets.chomp
    @order_repository.create(new_order)
    @io.puts "A new order was created!"
    @io.puts "Customer name: #{new_order.customer_name}, - Order date: #{new_order.order_date} - Item's code: #{new_order.item_id}"
  end

  def list_of_orders
    @order_repository = OrderRepository.new
    orders = @order_repository.all
    orders.sort_by! { |order| order.id.to_i }
    orders.each do |record| 
      @io.puts "Customer name: #{record.customer_name} - Order date: #{record.order_date}"
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_test_1',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
