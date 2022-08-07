require_relative 'lib/database_connection'
require_relative 'lib/item_repo'
require_relative 'lib/order_repo'

class Application
  def initialize(db_name, io, item_repo, order_repo)
    DatabaseConnection.connect('shop_manager')
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo
  end

  def run
    str = "What do you want to do?\n"
    str += "  1 = list all shop items\n  2 = create a new item\n"
    str += "  3 = list all orders\n  4 = create a new order\n"
    @io.puts str

    user = @io.gets.chomp

    if user == "1"
      @io.puts "\nHere's a list of all shop items:\n\n"
      @item_repo.all.each do |item|
        @io.puts "##{item.id} - #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.qty}"
      end
    end
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