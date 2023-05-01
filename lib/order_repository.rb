require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # creates a new record
  # one argument: an Order object
  def create(order)
    # Executes the SQL query
    # INSERT INTO artists (customer_name, date, item_id) VALUES ($1, $2, $3);
    
    # returns nothing
  end

  # def update(order)
  # end

  # def delete(order)
  # end
end