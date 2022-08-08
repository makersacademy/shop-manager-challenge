require_relative 'lib/database_connection'
require_relative 'lib/product_repository'
require_relative 'lib/order_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

class Application 
  

  def initialize(database, io, order_repository, product_repository)

    DatabaseConnection.connect(database)
    @io = io
    @order_repo = order_repository
    @product_repo = product_repository  

  end

  def run 
    
    @io.puts "Welcome to the shop management program! \n\n"
    @io.puts "What do you want to do?"
    @io.puts "1 - List all shop items"
    @io.puts "2 - Create a new item"
    @io.puts "3 - List all orders"
    @io.puts "4 - Create a new order"
    user = @io.gets.chomp 

    case user

    when "1"

      repo = @product_repo.all
      @io.puts "This is the list of products we sell: "
      repo.each do |inventory|
       
        @io.puts "##{inventory.id} - #{inventory.name} - Price: #{inventory.unit_price} - Quantity: #{inventory.quantity}"
      end

    when "2"

      @io.puts "What would you like to add into the inventory database?"
      item_name = @io.gets.chomp 
      new_item = Product.new 
      new_item.name = item_name
      @io.puts "What is the RRP for this product?"
      price = @io.gets.chomp 
      new_item.unit_price =  price.to_i 
      @io.puts "How many of these are available for sale?"  
      quantity = @io.gets.chomp 
      new_item.quantity = quantity.to_i
      
      @io.print @product_repo.create(new_item)
      

    when "3"

      repo = @order_repo.all
      @io.puts "This is the list of current orders: "
      repo.each do |order|
       
        @io.puts "##{order.id} - #{order.customer_name} - Date order placed: #{order.date_order_placed} - Item purchased: #{order.item_ordered}"
      end
      

    when "4"

      @io.puts "Creating a new order: What is the customer's name?"
      order_name = @io.gets.chomp 
      new_order = Order.new 
      new_order.customer_name = order_name
      @io.puts "When was the order placed?"
      date = @io.gets.chomp 
      new_order.date_order_placed = date
      @io.puts "What is the item being purchased - product ID?"
      product_id = @io.gets.chomp 
      new_order.item_ordered = product_id.to_i
      
      @io.print @order_repo.create(new_order)

    end

  end  

end 


app = Application.new('shop_manager', Kernel, OrderRepository.new, ProductRepository.new)

app.run

