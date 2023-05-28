require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'order_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end
  
  def show_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts "Choose from one of these options:"
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
