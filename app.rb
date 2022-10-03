require_relative 'lib/database_connection'
require_relative 'lib/items_repository'
require_relative 'lib/orders_repository'

class Application
  def initialize(shop_manager, io, items_repository, orders_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

  def run
    print_welcome
    print_options
    user_option(@io.gets.chomp)
  end

  def print_welcome
    @io.puts "\nWelcome to the Game-azon management program!"
  end

  def print_options
    @io.puts "\nWhat do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "9 = exit app\n\n"
    @io.puts "Enter:"
  end

## need to add loop in when I can get RSpec to not crash
  # def interactive_options
  #   loop do
  #     print_options
  #     user_option(STDIN.gets.chomp)
  #   end
  # end

  def user_option(input)
    case input
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order
    end
  end

    # to be added above
      # when "9"
    #   exit    <---- once loop is in, this will be added too
      # else
    #   puts "I don't know what you meant, try again"

  def list_items
    @io.puts "Here's a list of all shop items: \n"
    @items_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: £#{item.price} - Quantity: #{item.quantity}"
    end
  end

  def create_item
    @io.puts "Please enter an item name"
    name = @io.gets.chomp
    @io.puts "Please enter the item's price"
    price = @io.gets.chomp
    @io.puts "Please enter a quantity of items"
    quantity = @io.gets.chomp
    @io.puts "\nNew item added: "
    @io.puts "#{name} - Unit price: £#{price} - Quantity: #{quantity}"
     # Not 100% below works, would like more time to test
    item = Item.new
    item.name = name
    item.price = price
    item.quantity = quantity
    @items_repository.create(item)
  end

  def list_orders
    @io.puts "Here's a list of all orders: \n"
    @orders_repository.all.each do |order|
      @io.puts "##{order.id} Order name: #{order.customer_name} - Order date: #{order.date}"
    end
  end

  def create_order
    @io.puts "Please enter the customer's name"
    customer_name = @io.gets.chomp
    @io.puts "Please enter the order date (YYYY-MM-DD)"
    date = @io.gets.chomp
    @io.puts "\nNew order added: "
    @io.puts "New order: Customer name: #{customer_name} - Date: #{date}"
    # Not 100% below works, would like more time to test
    order = Order.new
    order.customer_name = customer_name
    order.date = date
    @orders_repository.create(order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager_full',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end