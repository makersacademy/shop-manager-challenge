require_relative './order.rb'

class OrderRepository

  def all
    sql = 'SELECT customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    
    result_set.each do |record|
      order = Order.new
      order.customer = record['customer']
      order.date = record['date']
      orders << order
    end
    return orders
  end

  def find(id)
    sql = 'SELECT customer, date FROM orders WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    order = Order.new
    order.customer = record['customer']
    order.date = record['date']
    return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
    params = [order.customer, order.date]
    DatabaseConnection.exec_params(sql, params)
  end
end