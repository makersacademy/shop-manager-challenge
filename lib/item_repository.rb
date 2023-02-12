class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Items objects.
  end

  # Gets a single item by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # creates an item object and doesn't return anything
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

    # deletes an item
  end

  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;
  end
end