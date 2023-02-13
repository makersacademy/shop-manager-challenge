require_relative './lib/database_connection'
require_relative './lib/order_repository'
require_relative './lib/item_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

class Application
  def initialize(shop_manager, io, order_repository, item_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts ''
    @io.puts 'What do you want to do?'
    @io.puts '  1 = list all shop items'
    @io.puts '  2 = create a new item'
    @io.puts '  3 = list all orders'
    @io.puts '  4 = create a new order'
  
    option = @io.gets.chomp.to_i
  
    case option
    when 1
      items = @item_repository.all
      @io.puts ''
      @io.puts 'Here\'s a list of all shop items:'
      items.each_with_index do |item, index|
        @io.puts " #{index + 1} #{item.title} - Unit price: #{item.price} - Quantity: #{item.stock}"
      end
    when 2
      @io.puts ''
      @io.puts 'Enter the title of the item:'
      title = @io.gets.chomp
      @io.puts 'Enter the price of the item:'
      price = @io.gets.chomp.to_i
      @io.puts 'Enter the stock of the item:'
      stock = @io.gets.chomp.to_i
  
      item = Item.new(title: title, price: price, stock: stock)
      @item_repository.create(item)
      @io.puts 'Item created successfully!'
    when 3
      orders = @order_repository.all
      @io.puts ''
      @io.puts 'Here\'s a list of all orders:'
      orders.each_with_index do |order, index|
        @io.puts " #{index + 1} Customer name: #{order.customer_name} - Order date: #{order.order_date}"
      end
    when 4
      @io.puts ''
      @io.puts 'Enter the customer name:'
      customer_name = @io.gets.chomp
      @io.puts 'Enter the order date:'
      order_date = @io.gets.chomp
  
      order = Order.new(customer_name: customer_name, order_date: order_date)
      @order_repository.create(order)
      @io.puts 'Order created successfully!'
    end
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