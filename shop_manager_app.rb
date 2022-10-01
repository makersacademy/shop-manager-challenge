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
    print_main
    process_main
  end

  def print_main
    @io.puts "Welcome to the Shop Manager!",""
    @io.puts "What would you like to do?"
    @io.puts " 1 - list all shop items"
    @io.puts " 2 - create a new item"
    @io.puts " 3 - list all orders"
    @io.puts " 4 - create a new order",""
    @io.puts "Enter you choice: "
    @selection = @io.gets.chomp
  end

  def process_main
    case @selection
      when "1"
        all_items
      when "2"
        user_intput_create_item
        create_item
      when "3"
        all_orders
      when "4"
        user_input_create_order
        create_order 
      when "exit"
        exit
    end
  end

  def all_items
    @io.puts "Here's a list of all shop items: "
    @item_repository.all_item.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end
  
  def user_intput_create_item
    @io.puts "Enter item name: "
    @name = @io.gets.chomp
    @io.puts "Enter Unit Price: "
    @unit_price = @io.gets.chomp
    @io.puts "Enter Quantity: "
    @quantity = @io.gets.chomp
    @io.puts "Item added successfully!"
  end

  def create_item
    @item_repository.create_item(item_record)
    all_items
  end

  def all_orders
    @io.puts "Here's a list of all shop orders: "
    @order_repository.all_order.each do |order|
      @io.puts "##{order.id} #{order.customer_name} - Ordered date: #{order.date_ordered} - Ordered item: #{order.item_name}"
    end 
  end

  def user_input_create_order
    @io.puts "Enter customer name: "
    @customer_name = @io.gets.chomp
    @io.puts "Enter date customer ordered: "
    @date_ordered = @io.gets.chomp
    @io.puts "Enter id of item customer ordered: "
    @item_id = @io.gets.chomp
    @io.puts "Enter id of customer: "
    @order_id = @io.gets.chomp

    @io.puts "Item added successfully!"
  end

  def create_order
    @order_repository.create_order(order_record)
    @order_repository.add_item_order_id(item_order_record)
    all_orders
  end

  private

  def item_record
    item = Item.new
    item.name = @name
    item.unit_price = @unit_price
    item.quantity = @quantity
    return item
  end

  def order_record
    order = Order.new
    order.customer_name = @customer_name
    order.date_ordered = @date_ordered
    return order
  end

  def item_order_record
    item_order = ItemOrder.new
    item_order.item_id = @item_id.to_i
    item_order.order_id = @order_id.to_i
    return item_order
  end

end

if __FILE__ == $0
  app = Application.new(
    'items_orders',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
