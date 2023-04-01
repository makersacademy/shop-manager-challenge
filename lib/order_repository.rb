require "order"

class OrderRepository
  def all
    orders = []
    sql = "SELECT id, customer_name, order_date FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      order = Order.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.order_date = record["order_date"]

      orders << order
    end

    return orders
  end

  def create(order)
    sql ="INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"
    params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end