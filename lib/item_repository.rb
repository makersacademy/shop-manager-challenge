require_relative 'item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    items = []
    # Executes the SQL query:
    sql = 'SELECT id, name, price, quantity FROM items;'

    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price'].to_i
      item.quantity = record['quantity'].to_i
      items << item
    end
    # Returns an array of Item objects.
    return items
  end

  # Create a new record
  # given a new Item Object
  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)
    # Does not return a value
  end

end
