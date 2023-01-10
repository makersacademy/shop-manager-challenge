require_relative 'database_connection'
require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT customer_name, order_date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders(result_set)
  end

  def orders(result)
    orders = []
    result.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']
      orders << order
    end 
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id)  VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.order_date, order.item_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
end
