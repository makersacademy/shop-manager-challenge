require_relative 'item'

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    results = DatabaseConnection.exec_params(sql, [])
    
    items = []
    results.each do |result|
      item = Item.new
      item.id = result['id']
      item.name = result['name']
      item.price = result['price']
      item.quantity = result['quantity']
      
      items << item
    end
    
    return items
    # Returns an array of Item objects.
  end
  # Creates a new record for the Item object passed to it
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
    # DatabaseConnection.exec_params(sql, [item.name, item.price, item.quantity])
    
    # Returns nothing
  end
end
