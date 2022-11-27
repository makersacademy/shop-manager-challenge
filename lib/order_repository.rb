require_relative 'item'
require_relative 'order'
require_relative 'item_order'

class OrderRepository

  def all 
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    orders = []
  
    result_set.each do |record|
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']

    orders << order
    end
  
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.order_date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_item(item_id)
    sql = 'SELECT orders.id, orders.customer_name, orders.order_date
              FROM orders
                JOIN items_orders ON items_orders.order_id = orders.id
                JOIN items ON items_orders.item_id = items.id
              WHERE items.id = $1;'
    sql_params = [item_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

end