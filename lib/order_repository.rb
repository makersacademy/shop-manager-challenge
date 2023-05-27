class OrderRepository

  # Selecting all orders
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;
    # Returns an array of Order objects.
  end

  def find(id)
    # id is an integer representing the order ID to search for
    # SELECT customer_name, order_date FROM orders WHERE id = $1;
    # Returns an instance of Order object
  end

  def create(order)
    # Executes the SQL query;
    # INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);
    # Doesn't need to return anything
  end

end