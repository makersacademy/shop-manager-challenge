require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the Shop Manager!"
    print_main
  end

  def print_main
    # while true do
    @io.puts ""
    @io.puts "What would you like to do?"
    @io.puts "1. List all shop items"
    @io.puts "2. Create a new item"
    @io.puts "3. List all orders"
    @io.puts "4. Create a new order"
    @io.puts "0. Exit"
    @io.puts "Choose action: "
    @selection = @io.gets.chomp
    @selection == '0' ? exit : user_menu
    # end
  end

  def user_menu
    case @selection
      when "1" then all_items
      when "2" then create_item
      when "3" then all_orders
      when "4" then create_order
    end
  end

  def all_items
    @io.puts "Here's a list of all shop items: "
    @item_repository.all_item.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
    end
  end
  
  def create_item
    @io.puts "Enter item name: "
    @name = @io.gets.chomp
    @io.puts "Enter Item Price: "
    @price = @io.gets.chomp
    @io.puts "Enter Quantity: "
    @quantity = @io.gets.chomp
    @item_repository.create_item(item_record)
  end

  def all_orders
    @io.puts "Here's a list of all shop orders: "
    @order_repository.all_order.each do |order|
      @io.puts "##{order.id} #{
        order.customer_name
        } - Ordered date: #{
          order.date
          } - Ordered item: #{order.item_name}"
    end 
  end

  def create_order
    @io.puts "Enter customer name: "
    @customer_name = @io.gets.chomp
    all_items
    @io.puts "Choose item: "
    @item_id = @io.gets.chomp
    @order_repository.create_order(order_record)
    @order_id = @order_repository.last_order_id
    @order_repository.add_order_item_id(order_item_record)
  end

  private

  def item_record
    item = Item.new
    item.name = @name
    item.price = @price
    item.quantity = @quantity
    return item
  end

  def order_record
    order = Order.new
    order.customer_name = @customer_name
    return order
  end

  def order_item_record
    order_item = OrderItem.new
    order_item.item_id = @item_id.to_i
    order_item.order_id = @order_id.to_i
    return order_item
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
