require_relative 'order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of order objects.
  end

  # creates a new order
  # returns nothing
  def create(order)
    # Executes the SQL query:
    # INSERT INTO order (customer_name, order_date) VALUES ($1, $2);
  end

  # adds an item to an order. 
  # fails if item is already on order?
  def assign_item_to_order(item_id, order_id)
    # Executes the SQL query:
    # INSERT INTO items_orders VALUES ($1, $2)
    # returns nothing.
  end

end