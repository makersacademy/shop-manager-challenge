require_relative 'order'

class OrderRepository
  # Creates instance varaible for kernel
  def initialize(terminal_io) # One argument - double
    @terminal_io = terminal_io
  end

  def list_all_orders
    sql = 'SELECT * FROM orders;'; orders = DatabaseConnection.exec_params(sql, [])

    all_orders = []

    orders.each do |order|
      order_object = Order.new
      order_object.id = order['id']; order_object.customer_name = order['customer_name']
      order_object.order_date = order['order_date']; order_object.item_id = order['item_id']
      all_orders << order_object
    end
    
    all_orders
  end

  # Creates a new order and inserts it into orders table
  # No arguments
  def create_new_order
    @terminal_io.puts 'What is the name of the customer?'
    customer_name = @terminal_io.gets.chomp

    @terminal_io.puts 'What is the order date (YYYY-MM-DD format)?'
    order_date = @terminal_io.gets.chomp

    @terminal_io.puts 'What is the item id for this order?'
    item_id = @terminal_io.gets.chomp

    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);'
    params = [customer_name, order_date, item_id]

    DatabaseConnection.exec_params(sql, params); @terminal_io.puts 'Order successfully created!'

    return nil
  end
end
