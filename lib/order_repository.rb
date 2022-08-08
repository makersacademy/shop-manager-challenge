require_relative 'order'

class OrderRepository
  def all
    sql = "SELECT * FROM orders;"
    DatabaseConnection.exec_params(sql, []).map do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date_ordered = record['date_ordered']
      order.item_id = record['item_id']
      order
    end
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, date_ordered, item_id) VALUES ($1, $2, $3);"
    DatabaseConnection.exec_params(sql, [order.customer_name, order.date_ordered, order.item_id])
  end
end
