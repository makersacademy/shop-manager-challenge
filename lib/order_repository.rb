require 'order'
require 'database_connection'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;

    # Returns an array of order objects.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(order)
  # end

  # def update(order)
  # end

  # def delete(order)
  # end
end