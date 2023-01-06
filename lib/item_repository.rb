require_relative "./item"

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);

    # returns nothing
  end

  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;

    # returns nothing
  end

  def delete(item)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

    # Returns nothing
  end
end