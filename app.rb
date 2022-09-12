require_relative 'lib/item'
require_relative 'lib/order'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application
  def initialize(database_connection:, io:, order_repository:, item_repository:)
    DatabaseConnection.connect('shop_test')
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
    @choice = []
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What do you want to do?'
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all orders'
    @io.puts '4 = create a new order'
    @choice = @io.gets.chomp
    output
  end

  def output
    if @choice == '1'
      print_item
    elsif @choice == '2'
      create_item
    elsif @choice == '3'
      print_order
    elsif @choice == '4'
      create_order
    end
  end

  def print_item
    item_repository = ItemRepository.new
    item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.stock}"
    end
  end

  def print_order
    order_repository = OrderRepository.new
    order_repository.all.each do |order|
      @io.puts "##{order.id} Customer: #{order.customer}, Date: #{order.date}"
    end
  end 

  def add(text)
    @io.puts text
    @io.gets.chomp
  end

  def create_item
    name = add "Item name:"
    price = add "Unit price:"
    stock = add "Quantity"
    new_item = Item.new
    @item_repository.create(new_item)
  end

  def create_order
    customer = add "Customer:"
    date = add "Date:"
    item = add "Item's ID:"
    new_order = Order.new
    @order_repository.create(new_order)
  end
end
if __FILE__ == $0
  app = Application.new(
    'shop_test',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end
