class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity, order_id FROM items;

    # Returns an array of order objects.
  end

  def create
  end

    # Select a single record
    # Given the id in argument(a number)

  def find(id) 
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity, order_id FROM items WHERE id = $1
  end 
end