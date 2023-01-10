require_relative "order"

class OrderRepository
  def all
    sql = 'SELECT orders.id, orders.customer_name, orders.order_date, items.item_name FROM orders INNER JOIN items ON orders.item=items.id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_name = record['item_name']
      orders << order
    end
    return orders
  end
end
