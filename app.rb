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
    print_menu
    choice = @io.gets.chomp
    @io.puts "\n"

    run_selected_task(choice)    
  end

  private

  def print_menu
    @io.puts "\nWhat do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = create a new item"
    @io.puts " 3 = list all orders"
    @io.puts " 4 = create a new order"
    @io.puts "\n"
  end

  def run_selected_task(choice)
    case choice
    when "1" then list_shop_items
    when "2" then add_new_shop_item
    when "3" then list_orders
    when "4" then add_new_order
    else @io.puts "Sorry I didn't understand that."
    end
  end

  def list_shop_items
    @io.puts "Here's a list of all shop items: \n\n"
    @shop_item_repository.all.each do |i|
      @io.puts "##{i.id} #{i.name} - Unit price: #{i.unit_price} - Quantity: #{i.quantity}"
    end
  end

  def add_new_shop_item
    @io.puts "Please enter the details of the item you want to create"
    @io.print "Name: "
    name = @io.gets.chomp
    @io.print "Unit price: "
    unit_price = @io.gets.chomp.to_f
    @io.print "Quantity: "
    quantity = @io.gets.chomp.to_i
    create_shop_item(name, unit_price, quantity)
  end

  def create_shop_item(name, unit_price, quantity)
    item = ShopItem.new
    item.name = name
    item.unit_price = unit_price
    item.quantity = quantity

    @shop_item_repository.create(item)
    @io.puts "Item created"
  end

  def list_orders
    @io.puts "Here's a list of all orders: \n\n"
    @order_repository.all.each do |order|
      format_date = DateTime.parse(order.date_placed).strftime '%d/%m/%Y'
      @io.puts "* Order id: #{order.id} - Customer name: #{order.customer_name}"
      @io.puts "  Date placed: #{format_date} - Item id: #{order.shop_item_id}"
    end
  end

  def add_new_order
    @io.puts "Please enter the order details"
    @io.print "Customer name: "
    customer_name = @io.gets.chomp
    @io.print "Date placed (YYYY-MM-DD HH:MM:SS): "
    date_placed = @io.gets.chomp
    @io.print "Shop Item Id: "
    shop_item_id = @io.gets.chomp
    create_order(customer_name, date_placed, shop_item_id)
  end

  def create_order(customer_name, date_placed, shop_item_id)
    order = Order.new
    order.customer_name = customer_name
    order.date_placed = date_placed
    order.shop_item_id = shop_item_id

    @order_repository.create(order)
    puts "Order added"
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
