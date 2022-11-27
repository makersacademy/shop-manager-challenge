require_relative 'order'
require_relative 'item'

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # # Executes the SQL query below:
    # sql = "SELECT id, customer_name, item_id, date FROM orders;"
    # result_set = DatabaseConnection.exec_params(sql, [])

    # orders = []

    # # loop through results and create an array of Order objects
    # # Return array of Order objects.
  end

  # Creating a new order record (takes an instance of Order)
  def create(order)
    # sql = "INSERT INTO orders (customer_name, item_id, date) VALUES($1, $2, $3);"
    # params = [order.customer_name, order.item_id, order.date]
    # DatabaseConnection.exec_params(sql, params)
  end
end