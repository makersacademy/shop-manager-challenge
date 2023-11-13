require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!\n \n"
    @io.puts "What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n"
    selection = @io.gets.to_i
    case selection
    when 1
      list_all_items
    when 2
      item_to_create
    when 3
      list_all_orders
    when 4
      order_to_create
    end
  end

  def list_all_items
    all_items = @item_repository.all
    @io.puts "\nHere's a list of all shop items:\n"
    all_items.each do |item|
    @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price}£ - Quantity: #{item.stock_quantity}"
    end
  end

  def create_new_item(name, unit_price, stock_quantity)
    @item_repository.create(name, unit_price, stock_quantity)
    @io.puts "The item #{name} has been created!"
  end

  def item_to_create
    @io.puts "What is the name of the item?"
    name = @io.gets.chomp
    @io.puts "What is the unit price of the item?"
    unit_price = @io.gets.to_f
    @io.puts "What is the stock quantity of the item?"
    stock_quantity = @io.gets.to_i
    create_new_item(name, unit_price, stock_quantity)
  end

  def list_all_orders
    all_orders = @order_repository.all
    @io.puts "\nHere's a list of all shop orders:\n"
    all_orders.each do |order|
      item_name = item_name_finder(order.item_id)
      @io.puts "##{order.id} - Customer's name: #{order.customer_name} - Date: #{order.date} - Ordered Item: #{item_name}"
    end
  end

  def item_name_finder(item_id)
    sql = "SELECT name FROM items WHERE id = $1"
    params = [item_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    return result_set.first['name']
  end

  def create_new_order(customer_name, date, item_id)
    @order_repository.create(customer_name, date, item_id)
    @io.puts "A new order for the item #{item_id} has been created!"
  end

  def order_to_create
    @io.puts "What is the customer's name of the new order?"
    customer_name = @io.gets.chomp
    @io.puts "When has the order been placed? (AAAA-MM-DD)"
    date = @io.gets
    @io.puts "What is the item's ID?\n \nPlease, select:"
    list_items_with_name_and_id
    item_id = @io.gets.to_i
    create_new_order(customer_name, date, item_id)
  end

  def list_items_with_name_and_id
    all_items = @item_repository.all
    all_items.each do |item|
      @io.puts "#{item.id} for #{item.name}"
    end
  end
end

#this runs the application
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end