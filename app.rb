# file: app.rb

require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager_test')

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT * FROM orders;'
# result = DatabaseConnection.exec_params(sql, [])
#
# # Print out each record from the result set .
# result.each do |record|
#   p record
# end

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @terminal_io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @terminal_io.puts "Welcome to the shop management program!"
    @terminal_io.puts "What do you want to do?"
    @terminal_io.puts "1 = list all shop items"
    @terminal_io.puts "2 = create a new item"
    @terminal_io.puts "3 = list all orders"
    @terminal_io.puts "4 = create a new order"

    user_input = @terminal_io.gets.chomp

    if user_input == "1"
      @item_repository.all.each do |item|
        @terminal_io.puts "#{item.id} - Item name:#{item.item_name} Unit price:#{item.unit_price} Quantity:#{item.quantity}"
      end
    elsif user_input == "2"
      create_item
    elsif user_input == "3"
      @order_repository.all.each do |order|
        @terminal_io.puts "#{order.id}: Customer name:#{order.customer_name} | Order date: #{order.order_date}"
      end
    elsif user_input == "4"
      create_order
    end

  end

  def create_item
    new_item = Item.new
    @terminal_io.puts "What is the item id?"
    id = @terminal_io.gets.chomp #item.id = 4
    new_item.id = id
    @terminal_io.puts "What would you like to name the item?"
    name = @terminal_io.gets.chomp #item.name = Oreo
    new_item.item_name = name

    @terminal_io.puts "What is the unit price?"
    unit_price = @terminal_io.gets.chomp #item.unit_price = $2.99
    new_item.unit_price = unit_price

    @terminal_io.puts "What is the quantity of this item?"
    quantity = @terminal_io.gets.chomp  #item.quantity = 10
    new_item.quantity = quantity

    @item_repository.create(new_item)
    @terminal_io.puts "Item created"
  end

  def create_order
    new_order = Order.new
    @terminal_io.puts "What is the order id?"
    id = @terminal_io.gets.chomp #order.id = 4
    new_order.id = id

    @terminal_io.puts "What is the customer name?"
    name = @terminal_io.gets.chomp #order.customer_name = Tammy
    new_order.customer_name = name

    @terminal_io.puts "What is the order date?"
    orderdate = @terminal_io.gets.chomp #order.order_date = 2022-03-02
    new_order.order_date = orderdate

    @order_repository.create(new_order)
    @terminal_io.puts "Order created"

  end

  end

  if __FILE__ == $0
    app = Application.new(
      'shop_manager_test',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
end

