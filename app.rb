require_relative 'lib/items_repository'
require_relative 'lib/orders_repository'
require_relative 'lib/database_connection'

class Application
  def initialize(database_name, io, items_repository, orders_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

  def run
    DatabaseConnection.connect('shop_manager')
    @items_repository = ItemRepository.new
    @orders_repository = OrderRepository.new
    welcome_choices
  end

  def welcome_choices
    @io.puts "Welcome to the Game-azon management program!\n"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order\n"
    @io.puts "Enter:"
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