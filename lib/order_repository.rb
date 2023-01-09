require_relative './order'

class OrderRepository
  def all
    sql = "SELECT id, customer_name, date, item_id FROM orders"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new

      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.date = record["date"]
      order.item_id = record["item_id"]
    
      orders.push(order)
    end

    return orders
  end

  # PROBABLY NOT NEEDED
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, cohort_name FROM orders WHERE id = $1;

  #   # Returns a single order object.
  # end

  # def create(order)
  # end

  #PROBABLY NOT NEEDED
  # def update(order)
  # end

  # def delete(id)
  # end
end