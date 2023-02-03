require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'
class Application
  def initialize(database_name, io, item_repo, order_repo)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo
  end

  def run
    @io.puts('Welcome to the shop management program!')
    @io.puts("\n")
    @io.puts('What do you want to do?')
    @io.puts('  1 = list all shop items')
    @io.puts('  2 = create a new item')
    @io.puts('  3 = list all orders')
    @io.puts('  4 = create a new order')
    option = @io.gets.chomp

    if option == '1'
      @io.puts("Here's a list of all shop items:")
      @io.puts("\n")
      @item_repo.all.each do |item|
        @io.puts(" ##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}")
      end
    end

  end
end

if __FILE__ == $0
  app = Application.new(
    'items_orders_2',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
