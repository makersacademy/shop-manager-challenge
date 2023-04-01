require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items WHERE id = $1;

    # Returns a single item object.
  end

  # Gets all the items in a specific order
  def find_by_order(order_id) # params for order_id will be $1
    # SELECT items.name, items.price FROM items JOIN items_orders ON items_orders.item_id = items.id
    # JOIN orders ON items_orders.order_id = orders.id WHERE orders.id = $1;
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
  end

  def update(item) # need to update quantity when an item is added to an order
    # UPDATE items SET quantity = $1 WHERE id = $2;
  end

  def delete(item) # when quantity reaches zero, need to delete item from stock
    # DELETE FROM items WHERE id = $1;
  end
end
