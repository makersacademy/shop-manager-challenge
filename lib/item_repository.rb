class ItemRepository
  # select all shop items
  def all_item
    # Executes the SQL query: SELECT id, name, unit_price, quantity FROM items

    # returns an array of Item objects
  end
  
  # Insert a new item record
  # Take an Item object in argument
  def create(item)
    # Executes the SQL query: INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # return nothing
  end
end 