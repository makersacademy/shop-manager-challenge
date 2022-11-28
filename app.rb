require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application
    database_name = 'store_manager_test'

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program! \n\n"
    @io.puts "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"
     choice = @io.gets.chomp
    case choice
    when '1'
      @item_repository.all.each do |item|
        @io.puts "##{item.id} #{item.product} - Unit price: #{item.price} - Quantity: #{item.quantity}"
      end
      run
    when '2'
      item = Item.new
      @io.puts "Enter name of product"
      item.product = @io.gets.chomp
      @io.puts "Enter unit price"
      item.price = @io.gets.chomp
      @io.puts "Enter quantitity"
      item.quantity = @io.gets.chomp
      @item_repository.add(item)
      run
    when '3'
      @order_repository.all.each do |order|
        @io.puts "#{order.customer} - #{order.date} - #{order.item_id}"
      end
      run
    when '4'
      order = Order.new
      @io.puts "Name of customer"
      order.customer = @io.gets.chomp
      @io.puts "Date of order yyyy-mm-dd"
      order.date = @io.gets.chomp
      @io.puts "list of item id in form x, y, z"
      order_items = @io.gets.chomp
      array = order_items.split(",")
      @order_repository.add(order, array)
      run
    else
      @io.puts 'Something went wrong'
      run
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end