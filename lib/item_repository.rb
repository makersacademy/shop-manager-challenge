require 'item'
require 'database_connection'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def find_by_order(id)
  # Executes the SQL query:
  # SELECT * FROM items JOIN items_orders ON items.id = items_orders.item_id JOIN orders ON items_orders.order_id = orders.id WHERE orders.id = $1;

  # Returns an array of Item objects from a single order
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  # user inputs item name, price, quantity
  # Executes the SQL query:
  # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

  # Returns nothing

  end

  def update(item)
  # user item name, price, quantity

  # Executes the SQL query:
  # UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;

  # Returns nothing
  end

  def delete(id)
  # Executes the SQL query:
  # DELETE FROM items WHERE id = $1;

  # Returns nothing
  end
end