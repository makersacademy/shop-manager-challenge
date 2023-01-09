require_relative 'database_connection'
require_relative '../lib/item_repo'
require_relative '../lib/order_repo'
require_relative '../lib/order'
require_relative '../lib/item'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "1 - List all shop items"
    @io.puts "2 - Create a new item"
    @io.puts "3 - List all orders"
    @io.puts "4 - Create a new order"

    user_choice = @io.gets.chomp

    if user_choice == "1"
      items_repo = ItemsRepository.new
      results = items_repo.all
      items = []
      results.each do |record|
        items << "#{record.item_name} - #{record.quantity} - #{record.unit_price}"
      end
      @io.puts items

    elsif user_choice == "2"
      items_repo = ItemsRepository.new
      @io.puts "What item do you want to add?"
      item_to_add = @io.gets.chomp
      @io.puts "How many do you want to add?"
      quantity_to_add = @io.gets.chomp
      @io.puts "What price do you want to add?"
      price_to_add = @io.gets.chomp
      items_repo.add(item_to_add, quantity_to_add,price_to_add)

    elsif user_choice == "3"
      orders_repo = OrdersRepository.new
      results = orders_repo.all
      orders = []
      results.each do |record|
        orders << "#{record.customer_name} - #{record.date} - #{record.item_choice}"
      end
      @io.puts orders

    elsif user_choice == "4"
      orders_repo = OrdersRepository.new
      @io.puts "Name of order"
      order_name = @io.gets.chomp
      @io.puts "Date of order"
      order_date = @io.gets.chomp
      @io.puts "Item chosen"
      order_item = @io.gets.chomp
      orders_repo.add(order_name,order_date,order_item) 
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    OrdersRepository.new,
    ItemsRepository.new
  )
  app.run
end