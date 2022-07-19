require_relative 'lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!\n\n"
    user_choice = nil
    until (user_choice == 1 || user_choice == 2 || user_choice == 3 || user_choice == 4 || user_choice == 5 || user_choice == 6)
      @io.puts "What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = view order details\n6 - view shop item balance"
      p user_choice = @io.gets.to_i
    end 
    case user_choice
    when 1
      list_items
    when 2
      create_item
    when 3
      list_orders
    when 4
      create_order_with_items
    when 5
      view_order_details 
    when 6
      view_item_with_orders
    end
  
  end

  private 

  def list_items
    @io.puts "Here's a list of all shop items:"
    @item_repository.all.map do |item|
      @io.puts "##{item.id} #{item.name} - unit price: #{item.unit_price} - quantity: #{item.quantity}"
    end
  end

  def create_item
    @io.puts "Please add item name, item price (1.00) and quantity available, separating them with commas:"
    params = @io.gets.split(",")
    item = Item.new
    item.name = params[0]
    item.unit_price = params[1]
    item.quantity = params[2]
    @item_repository.create(item)
    @io.puts "Item '#{item.name}' has been added to the stocklist."
  end

  def list_orders
    @io.puts "Here's a list of all orders:"
    @order_repository.all.map do |order|
      @io.puts "Order ##{order.id} - Customer: #{order.customer} - Date: #{order.date}"
    end
  end 

  def create_order_with_items
    @io.puts "Please add client name and the date of the order (YYYY-MM-DD), separating them with a comma"
    params = @io.gets.split(",")
    order = Order.new
    order.customer = params[0]
    order.date = params[1]
    selected_items = select_items
    @order_repository.create(order)
    order_id = @order_repository.all[-1].id
    selected_items.map do |item_id|
      sql = 'INSERT INTO items_orders VALUES ($1, $2);'
      params = [item_id, order_id]
      DatabaseConnection.exec_params(sql, params)
    end   
    @io.puts "Order ##{order_id} for #{order.customer} has been created on #{order.date}"
  end

  def select_items
    @io.puts "Please list the items you would like to add to your order, separating them with commas:"
    @item_repository.all.map do |item|
      @io.puts "##{item.id} #{item.name} - unit price: #{item.unit_price}"
    end 
    selected_items = @io.gets.chomp.split(",").map(&:to_i)
    return selected_items
  end
    
  def view_order_details 
    @io.puts "What is the order ID number?"
    id = @io.gets
    order = @order_repository.find_with_items(id)
    @io.puts "Order ##{order.id} - Customer: #{order.customer} - Date: #{order.date}"
    @io.puts "Here's the list of items ordered:"
    order.items.map do |item|
      @io.puts "##{item.id} #{item.name} - unit price: #{item.unit_price} - quantity available: #{item.quantity}"
    end
  end

  def view_item_with_orders
    @io.puts "What is the item ID number?"
    id = @io.gets
    item = @item_repository.find_with_orders(id)
    @io.puts "##{item.id} #{item.name} - unit price: #{item.unit_price} - quantity available: #{item.quantity}"
    @io.puts "This item was ordered by:"
    item.orders.map do |order|
      @io.puts "#{order.customer} = order ##{order.id} - date: #{order.date}"
    end
  end
end


# If we run this file using `ruby app.rb`,
# run the app.
if __FILE__ == $0
  app = Application.new(
    'shop_database',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end