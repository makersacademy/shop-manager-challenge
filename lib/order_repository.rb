require "order"

class OrderRepository
  def all
    orders = []
    sql = 'SELECT id, customer, date FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer = record['customer']
      order.date = record['date']
      orders << order
    end
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2)'
    params = [order.customer, order.date]
    DatabaseConnection.exec_params(sql, params)
  end
end