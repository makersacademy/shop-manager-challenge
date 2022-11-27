# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/print_items'
require_relative './lib/create_item'
require_relative './lib/print_orders'

class Application

  def initialize(database_name, io, item_repository, order_repository, print_items, create_item, print_orders)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @print_items = print_items
    @create_item = create_item
    @print_orders = print_orders
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
      @print_items.print_items(@item_repository, @io)
    when "2"
      @create_item.create_item(@item_repository, @io)
    when "3"
      @print_orders.print_orders(@order_repository, @io)
    when "4"
      create_order
    end
  end

  def create_order
    order = Order.new
    item_id_match = false
    order.order_date = ""

    @io.puts "Enter Customer name:"
    order.customer_name = @io.gets.chomp

    until order.order_date =~ /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/  do
      @io.puts "Enter Order date:"
      order.order_date = @io.gets.chomp
    end

    until item_id_match == true do   
    @io.puts "Enter Item ID:"
      order.item_id = @io.gets.chomp.to_i 
      @item_repository.all.each do |item|
        if item.id == order.item_id
          item_id_match = true
        end
      end
    end
    
    @order_repository.create(order)
    added_item = @order_repository.all.last.customer_name

    @io.puts "Order for #{added_item} has been added"
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
    PrintItems.new, 
    CreateItem.new, 
    PrintOrders.new
  )
  app.run
end