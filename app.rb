require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, 
        item_repository, order_repository, 
        item_class, order_class)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @item = item_class
    @order = order_class
  end

  def run
    greet_user
    choice = user_choice
    case choice
    when "1"
      display_items
    when "2"
      create_item
    when "3"
      display_orders
    when "4"
      get_order_input
      check_item_stock
      create_order
    when "5"
      update_stock
    end
  end

  private

  def greet_user
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
  end

  def user_choice
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    @io.puts "  5 = update stock of an item"
    choice = @io.gets.chomp
    @io.puts ""
    return choice
  end

  def display_items
    @io.puts "Here's a list of all shop items:"
    @io.puts ""
    @item_repository.all.each do |item|
      @io.puts str = " ##{item.id} #{item.name} - UP: #{item.unit_price} - Q: #{item.quantity}"
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
    @io.puts "Item successfully added"
  end

  def display_orders
    @io.puts "Here's a list of all the orders:"
    @io.puts ""
    @order_repository.all.each do |order|
      @io.puts " ##{order.id} #{order.customer_name} - Date: #{order.date_placed} - Item: #{order.item_name}"
    end
  end

  def get_order_input
    @io.puts "Customer's name:"
    @order.customer_name = @io.gets.chomp
    @io.puts "Date placed (YYYY-MM-DD):"
    @order.date_placed = @io.gets.chomp
    @io.puts "Item id:"
    @order.item_id = @io.gets.chomp.to_i
  end

  def check_item_stock
    order_item = @item_repository.find(@order.item_id)
    fail "Sorry, none in stock!" if order_item.quantity.zero?
  end

  def create_order
    @order_repository.create(@order)
    @io.puts "Order successfully added"
  end

  def update_stock
    @io.puts "Enter the item ID:"
    @item_repository.all.each do |item|
      @io.puts " ##{item.id}: #{item.name}, #{item.quantity}"
    end
    id = @io.gets.chomp.to_i
    @io.puts ""
    @io.puts "Enter the quantity added (or minus for removed):"
    quant = @io.gets.chomp.to_i
    @io.puts ""
    @item_repository.update_quantity(id, quant)
    @io.puts ""
    @io.puts "Stock updated successfully"
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
    Item.new,
    Order.new
  )
  app.run
end
  