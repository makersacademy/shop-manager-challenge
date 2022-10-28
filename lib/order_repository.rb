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
end