require_relative 'database_connection'
require_relative 'orders'

class OrdersRepository

  def all

    orders = []

    sql = "SELECT id, customer_name, order_date, item_id FROM orders;"

    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      order = Orders.new

      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']

      orders << order
    end
    orders
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);"
    params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end


end
