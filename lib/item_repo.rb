require_relative 'item'

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Create an item
  # Takes an Item object as an argument
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (id, name, unit_price, qty)
    # VALUES ($1, $2, $3, $4);

    # params = [item.id, item.name, item.unit_price, item.qty]
    # Returns nothing
  end

  # Update an item
  # Takes an Item object as an argument
  def update(item)
    # Executes the SQL query:
    # UPDATE items SET (id, name, unit_price, qty)
    # VALUES ($1, $2, $3, $4)
    
    # params = [item.id, item.name, item.unit_price, item.qty]
    # Returns nothing
  end
end