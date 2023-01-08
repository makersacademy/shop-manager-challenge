require 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id'].to_i
      orders << order
    end
  return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end