require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;
    sql = 'SELECT id, name, unit_price, quantity FROM items;'

    results = DatabaseConnection.exec_params(sql, [])

    # Returns an array of Item objects.
    items = []

    results.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items << item
    end

    return items
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    
    results = DatabaseConnection.exec_params(sql, [id])

    # Returns a single Item object.
    record = results[0]

    item = Item.new

    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    return item
  end

  # creates a single record
  # one argument: the Item model instance
  def create(item)
    # Executes the SQL query
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)

    # No return value, creates the record on database
  end

  # def update(item)
  # end

  # def delete(item)
  # end
end
