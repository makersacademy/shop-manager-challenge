require_relative "./order"

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES($1, $2);

    # returns nothing
  end

  def update(order)
    # Executes the SQL query:
    # UPDATE orders SET customer_name = $1, date = $2 WHERE id = $3;

    # returns nothing
  end

  def delete(order)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # Returns nothing
  end
end