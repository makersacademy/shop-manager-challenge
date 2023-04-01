require_relative './order'

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders;

    # Returns an array of order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders WHERE id = $1;

    # Returns a single order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order) # needs to assign items to the order using the join table
    # INSERT INTO orders (customer, date, items) VALUES ($1, $2, $3); # items will be an array of Item objects
    # INSERT INTO items_orders (item_id, order_id) VALUES ($4, $5); # will need to loop through item
    # array and do a new insert for every item
  end

  # def update(order)
  # end

  # def delete(order)
  # end
end
