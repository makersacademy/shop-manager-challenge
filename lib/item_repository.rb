require_relative './item'
require_relative './database_connection'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Insert new item 
  # item is a new Item object
  def create(item)
    # Executes the SQL query:

    # INSERT INTO albums (name, unit_price, quantity) VALUES($1, $2, $3);
    # Doesn't need to return anything (only creates a record)
  end

end