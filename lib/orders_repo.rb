require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_of_order FROM orders;

    # Returns an array of Album objects.
  end

  def create(order)
  end

    # Select a single record
    # Given the id in argument(a number)

  def find(id) 
    # Executes the SQL query:
    # SELECT id, name, date_of_order FROM orders WHERE id = $1
  end 
end