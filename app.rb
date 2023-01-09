require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    while true do

      @io.puts "Welcome to the shop management program!"
      @io.puts
      @io.puts "What do you want to do?"
      @io.puts "  1 = list all shop items"
      @io.puts "  2 = create a new item"
      @io.puts "  3 = list all orders"
      @io.puts "  4 = create a new order"
      @io.puts "  5 = Exit"

      while true do
        choice = @io.gets.chomp
        break if (choice == "1" || choice == "2" || choice == "3" || choice == "4" || choice == "5") 
      end

      case choice
        when "1"
          # list all shop items
          items = @item_repository.all
          items.each { |item| @io.puts "#{item.id} - #{item.name} - x #{item.quantity}"}
        when "2"
          # create a new item
          item = Item.new
          @io.puts "Item name: "
          item.name = @io.gets.chomp
          @io.puts "Unit Price: "
          item.unit_price = @io.gets.chomp
          @io.puts "Quantity: "
          item.quantity = @io.gets.chomp
          @item_repository.create(item)
        when "3"
          # list all orders
          orders = @order_repository.all
          orders.each { |order| @io.puts "#{order.id} - #{order.customer_name} - x #{order.item_id}"}
        when "4"
          # create a new order
          order = Order.new
          @io.puts "Customer name: "
          order.customer_name = @io.gets.chomp
          @io.puts "Order Date: "
          order.date = @io.gets.chomp
          @io.puts "Item ID "
          order.item__id = @io.gets.chomp
          @OrderRepository.create(order)
        when "5"
          break
      end
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end