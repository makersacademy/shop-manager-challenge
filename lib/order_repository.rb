class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders;

    # Returns an array of Orders objects.
  end

  # Gets a single item by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);

    # creates an order object and doesn't return anything
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # deletes an order
  end

  def update(order)
    # Executes the SQL query:
    # UPDATE order SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4;
  end
end