require_relative './database_connection'
require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, unit_price, quantity FROM items'
    repo = DatabaseConnection.exec_params(sql,[])
    items = []
    repo.each do |record|
      items << parse_record(record)
    end
    return items
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    record = DatabaseConnection.exec_params(sql,params)[0]
    return parse_record(record)
    # Returns a single Item object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
    sql = 'INSERT INTO items (name,unit_price,quantity) VALUES($1,$2,$3);'
    params = [item.name,item.unit_price,item.quantity]
    DatabaseConnection.exec_params(sql,params)
    # Doesn't need to return as only creates
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    DatabaseConnection.exec_params(sql,[id])
    # Doesn't need to return as only deletes
  end

  def update(item)
    sql = 'UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name,item.unit_price,item.quantity,item.id]
    DatabaseConnection.exec_params(sql,params)
    # Doesn't need to return as only updates
  end

  private

  def parse_record(record)
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    return item
  end
end
