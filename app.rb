require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_input_menu
    input = @io.gets.chomp
    @io.puts
    case input
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order
    end
  end

  private

  def print_input_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    @io.puts
  end

  def list_items
    @io.puts "Here is a list of all shop items:"
    @io.puts
    @item_repository.all.each do |item|
      @io.puts " #%d %s - Unit price: %0.2f - Quantity: %d" % [
        item.id, item.name, item.unit_price, item.quantity
      ]
    end
  end

  def create_item
    item = Item.new
    @io.puts "Please enter the new item below:"
    @io.print "id: "
    item.id = @io.gets.chomp.to_i
    @io.print "name: "
    item.name = @io.gets.chomp
    @io.print "unit price: "
    item.unit_price = @io.gets.chomp.to_f
    @io.print "quantity: "
    item.quantity = @io.gets.chomp.to_i
    @item_repository.create(item)
  end

  def list_orders
    @io.puts "Here is a list of all orders:"
    @io.puts
    @order_repository.all.each do |order|
      @io.puts " ##{order.id} #{order.customer_name} - Placed on #{order.date_placed}"
    end
  end

  def create_order
    order = Order.new
    @io.puts "Please enter the new order below:"
    @io.print "id: "
    order.id = @io.gets.chomp.to_i
    @io.print "customer name: "
    order.customer_name = @io.gets.chomp
    @io.print "date placed: "
    order.date_placed = @io.gets.chomp
    @io.puts
    @io.puts "Enter the ids of the items in the order:"
    @io.puts "(press ENTER a second time to create the order)"
    
    item_ids = []
    input = @io.gets.chomp
    until input == ""
      item_ids << input.to_i
      input = @io.gets.chomp
    end
    @order_repository.create(order, item_ids)
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
