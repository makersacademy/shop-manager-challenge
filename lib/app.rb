require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/order'
require_relative './lib/database_connection'

class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * an ItemRepository object (or a double of it)
  #  * an OrderRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    @io.puts " "

    while true
      choice = @io.gets.chomp.to_i
      # break if ['1','2','3','4'].include? choice
      break if [1..4].include? chomp
    end
    # choice = choice.to_i
    # @io.puts choice
    case choice
    when 1
      @io.puts (@item_repository.print_all)
    when 2
      @io.puts "Enter the item name:"
      # add functionality to make program more robust to user input
      item_name = gets.chomp
      @io.puts "Enter the item's unit price (A float,to two decimal places):"
      # add functionality to make program more robust to user input
      item_price = gets.chomp.to_f.round(2)
      @io.puts "Enter the item's quantity in the inventory:"
      # add functionality to make program more robust to user input
      item_quantity = gets.chomp.to_i
      item = Item.new
      item.name = item_name
      item.price = item_price
      item.quantity = item_quantity
      @item_repository.create(item)
    when 3
      @io.puts "Here's a list of all shop items:"
      @io.puts " "
      @io.puts (@order_repository.print_all)
    else 
      @io.puts "Enter the cumstomer name for the order:"
      # add functionality to make program more robust to user input
      order_name = gets.chomp
      @io.puts "Enter the date of the order in formatted like this: 12-Mar-2023"
      # add functionality to make program more robust to user input
      order_date = gets.chomp
      order = Order.new
      order.customer_name = order_name
      order.date = order_date
      @order_repository.create(order)
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
