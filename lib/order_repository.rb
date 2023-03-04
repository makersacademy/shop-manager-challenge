require "order"

class OrderRepository
  def all
    orders = []
    sql = 'SELECT id, customer, date, item_id FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer = record['customer']
      order.date = record['date']
      order.item_id = record['item_id']
      orders << order
    end
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, date, item_id) VALUES ($1, $2, $3)'
    params = [order.customer, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end
end
