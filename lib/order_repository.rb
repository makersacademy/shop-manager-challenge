require_relative 'order'
require_relative 'hash_values_to_integers'

class OrderRepository
  def all
    query = <<~SQL
      SELECT * FROM orders
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Order.new(hash_values_to_integers(_1)) }
  end

  def create(order)
    query = <<~SQL
      INSERT INTO orders (customer_name, date, item_id) 
      VALUES ($1, $2, $3)
    SQL
    params = [order.customer_name, order.date, order.item_id]
    DatabaseConnection.exec_params(query, params)
  end
end
