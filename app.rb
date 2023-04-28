require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"

    get_user_choice
  end

  private

  def get_user_choice
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
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
  