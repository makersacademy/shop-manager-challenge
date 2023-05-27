class ItemRepository

  # Selecting all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;
    # Returns an array of Item objects.
  end

  def find(id)
    # id is an integer representing the item ID to search for
    # SELECT name, unit_price, quantity FROM items WHERE id = $1;
    # Returns an instance of Item object
  end

end