require_relative 'order'
require_relative 'item'

class OrderRepository
  # Selects and returns all orders
  def all
    sql = "SELECT id, customer_name, item_id, date FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.item_id = record["item_id"]
      order.date = record["date"]

      orders << order
    end

    return orders
  end

  # Creates a new order record (takes an instance of Order)
  def create(order)
    raise "Only orders can be added" if (!order.is_a? Order)

    sql = "INSERT INTO orders (customer_name, item_id, date) VALUES($1, $2, $3);"
    params = [order.customer_name, order.item_id, order.date]
    DatabaseConnection.exec_params(sql, params)
  end
end