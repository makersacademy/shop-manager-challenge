require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:"
    result = @io.gets.chomp.to_i
    case result
      when 1
        @io.puts "\nHere's a list of all shop items:\n"
        @item_repository.all.each do |item|
          @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.stock_quantity}"
        end
      when 2
        @io.puts "\nPlease enter the NAME of the item and hit enter"
        new_name = @io.gets.chomp.to_s
        @io.puts "\nPlease enter the UNIT PRICE of the item and hit enter"
        new_unit_price = @io.gets.chomp.to_i
        @io.puts "\nPlease enter the STOCK QUANTITY of the item and hit enter"
        new_stock_quantity = @io.gets.chomp.to_i
        @io.puts "\nHere's a list of all shop items:\n"
        new_item = Item.new
        new_item.name, new_item.unit_price, new_item.stock_quantity = new_name, new_unit_price, new_stock_quantity
        @item_repository.create(new_item)
        @item_repository.all.each do |item|
          @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.stock_quantity}"
        end
      when 3
        @io.puts "\nHere's a list of all orders:\n"
        @order_repository.all.each do |order|
          @io.puts "##{order.id} Customer: #{order.customer_name} - Order date: #{order.order_date} - Item id: #{order.item_id}"
        end
      when 4
        @io.puts "\nPlease enter the CUSTOMER NAME of the order and hit enter"
        new_customer_name = @io.gets.chomp.to_s
        @io.puts "\nPlease enter the DATE of the order and hit enter (YYYY-MM-DD)"
        new_order_date = @io.gets.chomp.to_s
        @io.puts "\nPlease enter the ITEM ID of the order and hit enter"
        new_item_id = @io.gets.chomp.to_i
        @io.puts "\nHere's a list of all orders:\n"
        new_order = Order.new
        new_order.customer_name, new_order.order_date, new_order.item_id = new_customer_name, new_order_date, new_item_id
        @order_repository.create(new_order)
        @order_repository.all.each do |order|
          @io.puts "##{order.id} Customer: #{order.customer_name} - Order date: #{order.order_date} - Item id: #{order.item_id}"       
        end
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