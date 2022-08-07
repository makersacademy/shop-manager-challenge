require_relative 'order'
require_relative 'database_connection'

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of Order objects.
  end

  # Create an order
  # Takes an Order object as an argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed)
    # VALUES ($1, $2);

    # params = [order.customer_name, order.date_placed]
    # Returns nothing
  end

  # Update an order
  # Takes id of order to update and Order object as arguments
  def update(id, order)
    # Executes the SQL query:
    # UPDATE orders WHERE id = $3
    # SET (customer_name, date_placed) = ($1, $2)

    # params = [order.customer_name, order.date_placed, id]
    # Returns nothing
  end

  private

  def make_order(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order
  end
end