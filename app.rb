require_relative './lib/product_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application
  @running = true
  def initialize(database_name, io, product_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @product_repository = product_repository
    @order_repository = order_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What would you like to do?'
    @io.puts '1 - List all products'
    @io.puts '2 - Create a new item'
    @io.puts '3 - list all orders'
    @io.puts '4 - create a new order'
    @io.print 'Enter your choice: '
    input = @io.gets.to_i

    case input
    when 1
      @io.puts "Here's a list of all shop items:"
      get_products.each do |product|
            @io.puts "##{product.id} - #{product.name} - Quantity: #{product.quantity}"
      end

    when 2
      new_product = setup_new_product(@io)
      create_new_product(new_product)
      @io.puts "Item: #{new_product.name.upcase} added"

    when 3
      @io.puts "Here's a list of all orders:"

      get_orders.each do |order|
          @io.puts "##{order.id} - Customer name: #{order.customer_name} - Date: #{order.date}"
      end
    when 4
      new_order = setup_new_order(@io)
      create_new_order(new_order)
      @io.puts "Order by: #{new_order.customer_name.upcase} made"
    end
    
  end


  def get_products
    repo = @product_repository
    products = repo.all
    return products
  end


  def get_orders
    repo = @order_repository
    orders = repo.all
    return orders
  end

  def create_new_product(product)
    repo = @product_repository
    repo.create(product)
    return nil
  end

  def setup_new_product(io)
    new_product = Product.new
    @io.print "Product name: "
    new_product.name = @io.gets.upcase
    @io.print "Unit price: "
    new_product.unit_price = @io.gets
    @io.print "Quantity: "
    new_product.quantity = @io.gets
    return new_product
  end

  def create_new_order(order)
    repo = @order_repository
    repo.create(order)
    return nil
  end

  def setup_new_order(io)
    new_order = Order.new
    @io.print "Customer name: "
    new_order.customer_name = @io.gets
    new_order.date = Time.now.strftime("%Y-%m-%d")
    return new_order
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ProductRepository.new,
    OrderRepository.new
  )
    app.run
end