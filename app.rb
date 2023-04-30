require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository, item_class, order_class)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @item = item_class
    @order = order_class
  end

  def run
    greet_user
    choice = get_user_choice
    case choice
    when "1"
      display_items
    when "2"
      create_item
    when "3"
      display_orders
    when "4"
      create_order
    end
  end

  private

  def greet_user
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
  end

  def get_user_choice
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    choice = @io.gets.chomp
    @io.puts ""
    return choice
  end

  def display_items
    @io.puts "Here's a list of all shop items:"
    @io.puts ""
    @item_repository.all.each do |item|
      @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_item
    @io.puts "Item name:"
    @item.name = @io.gets.chomp
    @io.puts "Item price:"
    @item.unit_price = @io.gets.chomp.to_f
    @io.puts "Item quantity:"
    @item.quantity = @io.gets.chomp.to_i
    @item_repository.create(@item)
  end

  def display_orders
    @io.puts "Here's a list of all the orders:"
    @io.puts ""
    @order_repository.all.each do |order|
      @io.puts " ##{order.id} #{order.customer_name} placed an order on #{order.date_placed} for a #{order.item_name}"
    end
  end

  def create_order
    @io.puts "Customer's name:"
    @order.customer_name = @io.gets.chomp
    @io.puts "Date placed (YYYY-MM-DD):"
    @order.date_placed = @io.gets.chomp
    @io.puts "Item id:"
    @order.item_id = @io.gets.chomp.to_i
    @order_repository.create(@order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
    Item,
    Order
  )
  app.run
end
  