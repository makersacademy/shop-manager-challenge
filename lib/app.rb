require_relative 'orders'
require_relative 'orders_repository'
require_relative 'items'
require_relative 'items_repository'
require_relative 'database_connection'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    loop do
      display_menu
      break if choose_option == "q"
    end
  end

  def display_menu
    @io.puts "Welcome to the shop management program"
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all shop orders"
    @io.puts "4 = create a new  order"
  end

  def choose_option
    @io.puts "Enter an option (1-4) or q to quit:"
    option = @io.gets.chomp

    case option
      when "1"
        list_all_shop_items
      when "2"
        create_new_shop_item
      when "3"
        list_all_shop_orders
      when "4"
        create_new_shop_order
      when "q"
        @io.puts "Exiting..."
      else
        @io.puts "Invalid option"
    end

    option
  end

  def list_all_shop_items
    @item_repository.all.each do |item|
      @io.puts "#{item.id} - #{item.item_name} - #{item.price} - #{item.quantity}"
    end
  end

  def create_new_shop_item
    @io.puts "Enter item name:"
    item_name = @io.gets.chomp
    @io.puts "Enter item price:"
    price = @io.gets.chomp
    @io.puts "Enter item quantity:"
    quantity = @io.gets.chomp
    item = Items.new(item_name: item_name, price: price, quantity: quantity)
    @item_repository.create(item)
    @io.puts "Item added"
  end

  def list_all_shop_orders
    @order_repository.all.each do |order|
      @io.puts "#{order.id} - #{order.customer_name} - #{order.order_date} - #{order.item_id}"
    end
  end

  def create_new_shop_order
    @io.puts "Enter Customer Name:"
    customer_name = @io.gets.chomp
    @io.puts "Enter Order Date:"
    order_date = @io.gets.chomp
    @io.puts "Enter Item ID:"
    item_id = @io.gets.chomp
    order = Orders.new(customer_name: customer_name, order_date: order_date, item_id: item_id)
    @order_repository.create(order)
    @io.puts "Order added"
  end
end

# item_repository = ItemsRepository.new
# order_repository = OrdersRepository.new
# io = Kernel
# database_name = 'shop_manager'
# p app = Application.new(database_name, io, item_repository, order_repository)

# app.run
