# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new shop order"
    @io.puts ""
    input = @io.gets
    @io.puts ""
    @io.puts "Here's a list of all shop items:"
  end

  if __FILE__ == $0
    app = Application.new(
      'shop_inventory',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end
end