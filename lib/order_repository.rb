require_relative './order'
require_relative './database_connection'

class OrderRepository

  def all_orders

    sql = "SELECT * FROM orders;"
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    orders = []    
    result_set.each do |record|
      order = Order.new

      order.id = record['id']
      order.customer = record['customer']
      order.item = record['item']
      order.date = record ['date']

      orders << order
    end

    return orders
  end

  def create_order(order)
    sql = "INSERT INTO orders (customer, item, date) VALUES ($1, $2, $3);"
    sql_params = [order.customer, order.item, order.date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

end