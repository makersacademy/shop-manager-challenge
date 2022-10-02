require_relative 'database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    items = ItemRepository.new
    orders = OrderRepository.new
    @io.puts "\n Welcome to the shop management program!"
    @io.puts "\n What do you want to do?\n \n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order\n"
    input = @io.gets.to_i
    case input
      when 1 
        items.all.each do |item| @io.puts "Item ID: #{item.id} - Item: #{item.item_name} - PPU: £#{item.unit_price} - QTY: #{item.quantity}"
        end
      when 2
        create_item
      when 3
        orders.all.each do |order| @io.puts "Order ID: #{order.id} - Customer: #{order.customer_name} - Date: #{order.date}"
        end
      when 4
        create_order
    end
  end
end

  def create_item
    @io.puts "Please enter item ID:"
    id = @io.gets
    @io.puts "Please enter item name:"
    name = @io.gets
    @io.puts "Please enter unit price (£):"
    price = @io.gets
    @io.puts "Please enter stock quantity:"
    quantity = @io.gets
    item = Item.new
    item.id = id
    item.item_name = name
    item.unit_price = price
    item.quantity = quantity
    @item_repository.create(item)
  end

  def create_order
    @io.puts "Please enter order ID:"
    id = @io.gets
    @io.puts "Please enter customer name:"
    name = @io.gets
    order = Order.new
    order.id = id
    order.customer_name = name
    order.date = Time.new
    @order_repository.create(order)
  end

if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
