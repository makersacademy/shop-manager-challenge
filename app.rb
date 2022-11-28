require_relative "./lib/database_connection"
require_relative "./lib/item_repository"
require_relative "./lib/order_repository"
require_relative "./lib/item"
require_relative "./lib/order"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"

    choice = @io.gets.chomp

    case choice
    when "1" then list_items
    when "2" then create_item
    when "3" then list_orders
    when "4" then create_order
    end
  end

  private

  def list_items
    @io.puts "Here's a list of all shop items:"
    @item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def list_orders
    @io.puts "Here's a list of all orders:"
    @order_repository.all.each do |order|
      @io.puts "##{order.id} #{order.customer} - #{order.date}"
    end
  end

  def create_item
    new_item = Item.new
    @io.puts "Item name:"
    new_item.name = @io.gets.chomp
    @io.puts "Unit price:"
    new_item.unit_price = @io.gets.chomp.to_i
    @io.puts "Quantity:"
    new_item.quantity = @io.gets.chomp.to_i

    @item_repository.create(new_item)
  end

  def create_order
    new_order = Order.new
    @io.puts "Customer name:"
    new_order.customer = @io.gets.chomp
    @io.puts "Order date:"
    new_order.date = @io.gets.chomp

    @order_repository.create(new_order)
  end
end

if __FILE__ == $0
  app = Application.new(
    "shop_manager",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
