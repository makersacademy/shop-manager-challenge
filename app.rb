require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts " 1 - list all shop items"
    @io.puts " 2 - create a new item"
    @io.puts " 3 - list all orders"
    @io.puts " 4 - create a new order" 
    choice = @io.gets.chomp

    if choice == "1"
      @io.puts "here is the list of all shop items:"
      @item_repository.all.each do |item|
        @io.puts "##{item.id} - #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    end

    if choice == "2" 
      item = Item.new
      @io.puts "Please enter the item name"
      item.name = @io.gets.chomp
      @io.puts "Please enter the item unit price"
      item.unit_price = @io.gets.chomp.to_i
      @io.puts "Please enter the item quantity"
      item.quantity = @io.gets.chomp.to_i

      @item_repository.create(item)
      new_item = @item_repository.all.last
      @io.puts "Item added: ##{new_item.id} - #{new_item.name} - Unit price: #{new_item.unit_price} - Quantity: #{new_item.quantity}"
    end
    
    if choice == "3"
      @io.puts "here is the list of all orders:"
      @order_repository.all.each do |order|
        @io.puts "##{order.id} - #{order.customer_name} - Order date: #{order.order_date} - Item ID: #{order.item_id}"
      end
    end

    if choice == "4" 
      order = Order.new
      @io.puts "Please enter the customer name"
      order.customer_name = @io.gets.chomp
      @io.puts "Please enter the order date"
      order.order_date = @io.gets.chomp
      @io.puts "Please enter the item ID"
      order.item_id = @io.gets

      @order_repository.create(order)
      new_order = @order_repository.all.last
      @io.puts "Order added: ##{new_order.id} - #{new_order.customer_name} - Unit price: #{new_order.order_date} - Quantity: #{new_order.item_id}"
    end

  end
end

if __FILE__ == $0
  Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  ).run
end
