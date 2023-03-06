require 'order'

class OrderRepository
  def initialize
  end

  def all
    orders = []

    sql = "SELECT * FROM orders;"
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |row|
      order = Order.new

      order.id = row["id"]
      order.customer_name = row["customer_name"]
      order.order_date = row["order_date"]

      orders << order
    end
    return orders
  end

  def create_order(customer_name, order_date)
    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"
    DatabaseConnection.exec_params(sql, [customer_name, order_date])
  end
end