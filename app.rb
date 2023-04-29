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
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts ""
    selection = @io.gets.to_i
    
    case selection
    when 1
      list_all_items
    when 2
      item_to_create
    when 3
      list_all_orders
    when 4
      create_new_order
    end
  end

  def list_all_items
    all_items = @item_repository.all
    puts ""
    puts "Here's a list of all shop items:"
    puts ""
    all_items.each do |item|
    p "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.stock_quantity}"
    end
  end

  def create_new_item(name, unit_price, stock_quantity)
    @item_repository.create(name, unit_price, stock_quantity)
    p "Item #{name} has been created!"
  end

  def item_to_create
    puts "What is the name of the item?"
    name = @io.gets.chomp
    puts "What is the unit price of the item?"
    unit_price = @io.gets.to_f
    puts "What is the stock quantity of the item?"
    stock_quantity = @io.gets.to_i
    create_new_item(name, unit_price, stock_quantity)
  end

  def list_all_orders
    all_orders = @order_repository.all
    puts ""
    puts "Here's a list of all shop orders:"
    puts ""
    all_orders.each do |order|
    p "##{order.id} - Customer's name: #{order.customer_name} - Date: #{order.date} - Ordered Item: #{order.item_id}"
    end
  end

  def create_new_order

  end
end

#this runs the application
if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end