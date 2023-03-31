require "item.rb"

class ItemRepository
  # Select all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Insert a new item
  # One argument
  def create(item) # an item object
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # Returns nothing
  end
end