require_relative 'order'
require_relative 'item'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])

    orders = []

    result.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']

      orders << order
    end
    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, date FROM orders WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    order = Order.new
    result.each do |record|
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
    end
    return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    params = [order.customer_name, order.date]

    DatabaseConnection.exec_params(sql, params)
  end
end