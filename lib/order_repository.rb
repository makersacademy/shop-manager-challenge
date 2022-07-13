require_relative 'order'
require_relative 'database_connection'
class OrderRepository
  def initialize(io)
    @io = io
  end

  def all_orders
    sql = 'SELECT * FROM orders;'

    result_set = DatabaseConnection.exec_params(sql,[])
    orders = []
    result_set.each do |result|
      new_order = assign_order(result)
      orders << new_order
    end
    return orders
  end

  def assign_order(result)
    order = Order.new
    order.id = result["id"].to_i
    order.customer_name = result["customer_name"]
    order.order_date = result["order_date"]
    order.item_id = result["item_id"].to_i
    return order
  end

  def add_order
    @io.puts "Add order"
    params = order_info
    sql = 'INSERT INTO orders ("id", "customer_name", "order_date", "item_id")
     VALUES ($1, $2, $3, $4);'
    DatabaseConnection.exec_params(sql, params)
    @io.puts "Order added!"
    return nil
  end

  def order_info
    @io.puts "What is the order id?"
    order_id = @io.gets.to_i
    @io.puts "What is the customer's name?"
    order_customer_name = @io.gets.chomp.to_s
    @io.puts "What is the order date?"
    order_date = @io.gets.chomp.to_s
    @io.puts "What is the ordered item's id?"
    order_item_id = @io.gets.to_i
    return params = [order_id, order_customer_name, order_date, order_item_id]
    
  end
end
