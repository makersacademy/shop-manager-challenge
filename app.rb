# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/print_items'
require_relative './lib/create_item'
require_relative './lib/print_orders'
require_relative './lib/create_order'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    print_menu
    process(@io.gets.chomp)
  end

  private

  def print_menu
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
  end

  def process(selection)
    case selection
    when "1"
      items = PrintItems.new(@item_repository, @io)
      items.print_items
    when "2"
      item = CreateItem.new(@item_repository, @io)
      item.create_item
    when "3"
      orders = PrintOrders.new(@order_repository, @io)
      orders.print_orders
    when "4"
      order = CreateOrder.new(@item_repository, @order_repository, @io)
      order.create_order
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