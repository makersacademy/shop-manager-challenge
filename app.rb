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
      break if [1,2,3,4].include? choice
    end
    case choice
    when 1
      @io.puts (@item_repository.print_all)
    when 2
      @io.puts "Enter the item name:"
      # add functionality to make program more robust to user input
      item_name = @io.gets.chomp
      @io.puts "Enter the item's unit price (A float,to two decimal places):"
      # add functionality to make program more robust to user input
      item_price = @io.gets.chomp.to_f.round(2)
      @io.puts "Enter the item's quantity in the inventory:"
      # add functionality to make program more robust to user input
      item_quantity = @io.gets.chomp.to_i
      item = Item.new
      item.name = item_name
      item.unit_price = item_price.to_f.round(2)
      item.quantity = item_quantity.to_i
      @item_repository.create(item)
    when 3
      @io.puts "Here's a list of all shop items:"
      @io.puts " "
      @io.puts (@order_repository.print_all_with_items)
    else 
      @io.puts "Enter the customer name for the order:"
      # add functionality to make program more robust to user input
      order_name = @io.gets.chomp
      order_date = Date.today.strftime("%Y-%m-%d")
      order = Order.new
      order.customer_name = order_name
      order.date = order_date
      all_items = @item_repository.all
      @io.puts "Select the items you'd like to order:"
      all_items.each do |item|
        @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity available: #{item.quantity}"
        @io.puts "Select? Y/N"
        answer = @io.gets.chomp
        order.items << item if answer.match(/(?i)\by\b|\b(yes)\b/)
      end
      @order_repository.create(order)
      @io.puts "Order ID: #{@order_repository.all_with_items.last.id} confirmed!"
    end
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
