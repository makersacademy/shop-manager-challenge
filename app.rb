# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/print_items'
require_relative './lib/create_item'
require_relative './lib/print_orders'
require_relative './lib/create_order'

class Application

  def initialize(database_name, io, item_repository, order_repository, create_item, print_orders, create_order)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    # @print_items = print_items(@item_repository, @io)
    @create_item = create_item
    @print_orders = print_orders
    @create_order = create_order
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
      print_items = PrintItems.new(@item_repository, @io)
      print_items.print_items
    when "2"
     
      @create_item.create_item(@item_repository, @io)
    when "3"
      @print_orders.print_orders(@order_repository, @io)
    when "4"
      @create_order.create_order(@item_repository, @order_repository, @io)
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
    # PrintItems.new, 
    CreateItem.new, 
    PrintOrders.new, 
    CreateOrder.new
  )
  app.run
end