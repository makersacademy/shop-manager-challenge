require_relative "./order"

class OrderRepository
  def all
    orders = []
    sql = "SELECT * FROM orders;"
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |item|
      order = Order.new
      order.id = item["id"]
      order.customer_name = item["customer_name"]
      order.order_date = item["order_date"]

      orders << order
    end
    orders
  end

  def find(id)
    sql = "SELECT id, customer_name, order_date FROM orders WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    item = result[0]
    order = Order.new
    order.id = item["id"]
    order.customer_name = item["customer_name"]
    order.order_date = item["order_date"]

    return order
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"
    params = [order.customer_name, order.order_date]
    result = DatabaseConnection.exec_params(sql, params)
  end
end
