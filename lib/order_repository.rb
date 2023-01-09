require_relative "order"

class OrderRepository
  def all
    sql = "SELECT * FROM orders"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |result|
      order = Order.new
      order.id = result['id'].to_i
      order.customer_name = result['customer_name']
      order.order_date = result['order_date']
      order.item_id = result['item_id'].to_i
      orders << order
    end
    return orders;
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3)"
    params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end
end