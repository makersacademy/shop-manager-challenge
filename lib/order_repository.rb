require_relative '../lib/order'
require_relative '../lib/database_connection'

class OrderRepository

  def all
    sql = 'SELECT id, customer, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
      orders << orderise(record)
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, order_date) VALUES ($1, $2);'
    sql_params = [order.customer, order.order_date]
        
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def orderise(record)
    order = Order.new
    order.id = record['id']
    order.customer = record['customer']
    order.order_date = record['order_date']

    return order
  end
end
