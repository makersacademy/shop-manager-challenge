require_relative './lib/item_repository'
require_relative './lib/order_repository'


class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_header
    print_options
    process(@io.gets.chomp)
  end

  def print_header
    @io.puts "Welcome to the shop management program!"
  end

  def print_options
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "Enter your choice:"
  end

  def process(selection)
    case selection
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order
    else
      @io.puts "I don't know what you meant, please try again"
    end
  end

  def list_items
    @io.puts "Here's a list of all shop items:"
    @item_repository.all.each do |item|
      @io.puts "#{item.id} - Unit price: #{item.price} - Quantity: #{item.quantity}"
    end
  end

  def create_item
    item = Item.new
    @io.puts "Please enter item name:"
    item.name = @io.gets.chomp
    @io.puts "Please enter item price:"
    item.price = @io.gets.chomp
    @io.puts "Please enter item quantity:"
    item.quantity = @io.gets.chomp
    @item_repository.create(item)
  end

  def list_orders
    @io.puts "Here's a list of all shop orders:"
    @order_repository.all.each do |order|
      @io.puts "#{order.id} - Customer: #{order.customer} - ordered on: #{order.date}"
    end
  end

  def create_order
    order = Order.new
    @io.puts "Please enter customer name:"
    order.customer = @io.gets.chomp
    @io.puts "Please enter the date of the order:"
    order.date = @io.gets.chomp
    @order_repository.create(order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'book_store_solo',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end