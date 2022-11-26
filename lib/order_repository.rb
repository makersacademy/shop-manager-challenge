require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT id, date, customer_name, item_id, quantity FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.date = record['date']
      order.customer_name = record['customer_name']
      order.item_id = record['item_id']
      order.quantity = record['quantity']

      orders << order
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ($1, $2, $3, $4);'
    params = [order.date, order.customer_name, order.item_id, order.quantity]

    result_set = DatabaseConnection.exec_params(sql, params)
  end
end