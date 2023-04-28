require_relative "./order"

class OrderRepository
  def all
    sql = "SELECT * FROM orders;"
    records = DatabaseConnection.exec_params(sql, [])
    orders = []

    records.each do |record|
      order = Order.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.date_placed = record["date_placed"]
      orders << order
    end
    orders
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, date_placed)
            VALUES ($1, $2)"
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
  end
end