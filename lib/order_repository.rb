require_relative "database_connection"
require_relative "order"

class OrderRepository

  def all
    query = "SELECT * FROM orders"
    results = DatabaseConnection.exec_params(query, [])
    results.map do |result|
      Order.new([result["id"],
      result["customer_name"],
      result["date"],
      result["item_id"]])
    end
  end

  def create(order)
    query = "INSERT INTO orders (customer_name, date, item_id) 
    VALUES ('#{order.customer_name}', '#{order.date}', #{order.item_id})"
    DatabaseConnection.exec_params(query, [])
  end

end
