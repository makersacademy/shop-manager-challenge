require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/item'
require_relative './lib/order'
require_relative './lib/database_connection'

class Application

  def initialize(database_name, terminal, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    menu_string = "Welcome to the shop management program!\n\n" \
                  "What do you want to do?\n" \
                  "  1 = list all shop items\n" \
                  "  2 = create a new item\n" \
                  "  3 = list all orders\n" \
                  "  4 = create a new order"
    @terminal.puts menu_string
    choice = @terminal.gets.chomp

    case choice
    when "1"
      list_all_items()
    when "2"
      create_item()
    when "3"
      list_all_orders()
    when "4"
      create_order()
    end
  end

  def list_all_items
    output = ""
    @item_repository.all.each do |item|
      output += "##{item.id} #{item.name} - "
      output += "Unit price: #{item.unit_price.round} - "
      output += "Quantity: #{item.stock_quantity}\n"
    end
    @terminal.puts "\nHere's a list of all shop items:\n\n#{output.chomp}"
  end

  def create_item
    item = Item.new
    @terminal.print "Enter item name: "
    item.name = @terminal.gets.chomp
    @terminal.print "Enter unit price: "
    item.unit_price = @terminal.gets.chomp.to_f
    @terminal.print "Enter stock quantity: "
    item.stock_quantity = @terminal.gets.chomp.to_i
    @item_repository.create(item)
    @terminal.puts "New item added."
  end

  def list_all_orders
    output = ""
    @order_repository.all_with_item.each do |entry|
      order = entry[0]
      item_name = entry[1]
      output += "##{order.id} #{order.customer_name} - #{order.order_date} - "
      output += "#{item_name}\n"
    end
    @terminal.puts "\nHere's a list of all orders:\n\n#{output.chomp}"
  end

  def create_order
    order = Order.new
    list_all_items()
    @terminal.print "Pick an item by id: "
    order.item_id = @terminal.gets.chomp.to_i
    @terminal.print "Enter customer name: "
    order.customer_name = @terminal.gets.chomp
    @terminal.print "Enter order date(yyyy-mm-dd): "
    order.order_date = @terminal.gets.chomp
    @order_repository.create(order)
    @terminal.puts "New order added."
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
