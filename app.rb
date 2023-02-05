require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_header
    process
  end

  private

  def print_header
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
  end

  def process
    user_input = @io.gets.chomp
    if user_input == "1"
      lists_items
    elsif user_input == "2"
      create_new_item
    elsif user_input == "3"
      lists_orders
    elsif user_input == "4"
      create_new_order
    else
      @io.puts "Please, select a number between 1 and 4"
    end
  end

  def lists_items
    @item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_new_item
    new_item = Item.new

    @io.puts "insert the name of the item"
    new_item.name = @io.gets.chomp
    @io.puts "insert the price of the item"
    new_item.unit_price = @io.gets.chomp
    @io.puts "insert the quantity of the item"
    new_item.quantity = @io.gets.chomp

    @item_repository.create(new_item)
  end

  def lists_orders
    @order_repository.all.each do |order|
      @io.puts "#{order.id} - Customer name: #{order.customer_name} -  Date: #{order.date}"
    end
  end

  def create_new_order
    new_order = Order.new

    @io.puts "insert the name of the customer"
    new_order.customer_name = @io.gets.chomp
    @io.puts "insert the date of the order (dd/mm/yyyy)"
    new_order.date = @io.gets.chomp
    @io.puts "insert the item id"
    new_order.item_id = @io.gets.chomp
    
    @order_repository.create(new_order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end
