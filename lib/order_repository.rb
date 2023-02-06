require_relative 'order'
require_relative 'database_connection'

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id']

      orders << order
    end

    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;'
    sql_params = [id]
  
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
  
    order = Order.new
    order.id = 1
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']
  
    return order
  end
end