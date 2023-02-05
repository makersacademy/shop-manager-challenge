require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/database_connection'


class Application 
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run 
    print_menu
    selection
  end 

  def print_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
  end 
end

  def selection
    choice = @io.gets.chomp
    
    case choice 
    when "1"
      list_shop_items
    when "2"
      create_item
    when "3"
      list_shop_orders
    when "4"
      create_order
    else 
      @io.puts "That's not a valid option."
    end 
  end 

  def list_shop_items
    @io.puts "Here's a list of shop items:"
    @item_repository.all.each do |item|
      @io.puts "#{item.id} - #{item.name} - Unit Price: £#{item.price} - Quantity: #{item.quantity}"
    end
  end 

  def create_item
    item = Item.new
    @io.puts "Enter the name of the item: "
    item.name = @io.gets.chomp
    @io.puts "Enter the unit price: "
    item.price = @io.gets.chomp.to_i
    @io.puts "Enter the quantity: "
    item.quantity = @io.gets.chomp.to_i

    #item.price = item.price.to_i
    #item.quantity = item.quantity.to_i
    @item_repository.create(item)

    @io.puts "New Item Created."

  end 

  def list_shop_orders
    @io.puts "Here's a list of shop orders:"
      @order_repository.all.each do |order|
      @io.puts "#{order.id} - Customer Name: #{order.customer_name} - Order date: #{order.order_date} - Item ID: #{order.item_id}"
    end
  end 

  def create_order
    order = Order.new
    @io.puts "Enter the customer name: "
    order.customer_name = @io.gets.chomp
    @io.puts "Enter the order date in format YYYY-MM-DD: "
    order.order_date = @io.gets.chomp
    @io.puts "Enter the item ID: "
    order.item_id = @io.gets.chomp.to_i
    
    @order_repository.create(order)

    @io.puts "New Order Created."

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
