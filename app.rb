# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

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
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    @io.puts ""
    choice = @io.gets.chomp
    @io.puts ""

    case choice
    when '1'
      @io.puts "Here's a list of all shop items:"
      @item_repository.all.each do |record|
        @io.puts " ##{record.id} #{record.name} - Unit price: #{record.unit_price} - Quantity: #{record.quantity}"
      end
    when '2'
      item = Item.new
      @io.print "What is the item name? "
      item.name = @io.gets.chomp
      @io.print "What is the item unit price? "
      item.unit_price = @io.gets.chomp.to_i
      @io.print "What is the item quantity? "
      item.quantity = @io.gets.chomp.to_i
      @item_repository.create(item)
      @io.puts "This item has been added:"
      item = @item_repository.all.last
      @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    when '3'
      @io.puts "Here's a list of all shop orders:"
      @order_repository.all.each do |record|
        @io.puts " ##{record.id} #{record.customer_name} - Order date: #{record.order_date} - Item ID: #{record.item_id}"
      end
    when '4'
      order = Order.new
      @io.print "What is the order customer name? "
      order.customer_name = @io.gets.chomp
      @io.print "What is the order date? "
      order.order_date = @io.gets.chomp
      @io.print "What is the order item ID? "
      order.item_id = @io.gets.chomp.to_i
      @order_repository.create(order)
      @io.puts "This order has been added:"
      order = @order_repository.all.last
      @io.puts " ##{order.id} #{order.customer_name} - Order date: #{order.order_date} - Item ID: #{order.item_id}"  
    else
      @io.puts "ERROR: Please enter valid option!"
    end
  end
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