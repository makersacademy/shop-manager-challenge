require "order"

class OrderRepository
  # Select all orders
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;

    # Returns an array of Order objects.
  end

  # Insert a new order
  # One argument
  def create(order) # an order object
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);

    # Returns nothing
  end
end