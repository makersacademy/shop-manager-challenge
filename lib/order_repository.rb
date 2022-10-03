require_relative './order'
require_relative './database_connection'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date_order_placed, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date_order_placed = record['date_order_placed']
      order.item_id = record['item_id']
    
      orders << order
    end
    return orders
  end
  
  def create(order)
    sql = 'INSERT INTO 
    orders (customer_name, date_order_placed, item_id) 
    VALUES($1, $2, $3);'
    sql_params = [order.customer_name, order.date_order_placed, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end