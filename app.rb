require_relative 'lib/database_connection'
require_relative 'lib/shop_item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, shop_item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @shop_item_repository = shop_item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = create a new item"
    @io.puts " 3 = list all orders"
    @io.puts " 4 = create a new order"
    @io.puts "\n"
    choice = @io.gets.chomp
    @io.puts "\n"

    if choice == "1"
      @shop_item_repository.all.each do |item|
        @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    elsif choice == "2"
      @io.puts "Please enter the details of the item you want to create"
      @io.print "Name: "
      name = @io.gets.chomp
      @io.print "Unit price: "
      unit_price = @io.gets.chomp.to_f
      @io.print "Quantity: "
      quantity = @io.gets.chomp.to_i

      item = ShopItem.new
      item.name = name
      item.unit_price = unit_price
      item.quantity = quantity

      @shop_item_repository.create(item)
      @io.puts "Item created"
    elsif choice == "3"
      @order_repository.all.each do |order|
        format_date = DateTime.parse(order.date_placed).strftime '%d/%m/%Y'
        @io.puts "* Order id: #{order.id} - Customer name: #{order.customer_name}"
        @io.puts "  Date placed: #{format_date} - Item id: #{order.shop_item_id}"
      end
    elsif choice == "4"
      @io.puts "Please enter the order details"
      @io.print "Customer name: "
      customer_name = @io.gets.chomp
      @io.print "Date placed (YYYY-MM-DD HH:MM:SS): "
      date_placed = @io.gets.chomp
      @io.print "Shop Item Id: "
      shop_item_id = @io.gets.chomp

      order = Order.new
      order.customer_name = customer_name
      order.date_placed = date_placed
      order.shop_item_id = shop_item_id

      @order_repository.create(order)
      puts "Order added"
    else
      @io.puts "Sorry I didn't understand that."
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ShopItemRepository.new,
    OrderRepository.new
  )
  app.run
end
