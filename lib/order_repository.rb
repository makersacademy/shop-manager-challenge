require_relative './order'
require_relative './database_connection'

class OrderRepository
  def all
    sql = 'SELECT id, customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer = record['customer']
      order.date = record['date']
      all_orders << order
    end
    return all_orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
    sql_param = [order.customer, order.date]
    DatabaseConnection.exec_params(sql, sql_param)
  end
end