# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the OrderRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop managment program!"
    # loop do
    @io.puts "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order"
    # end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
