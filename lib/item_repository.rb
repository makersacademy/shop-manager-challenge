require_relative 'database_connection'
require_relative 'item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    items = []

    result_set.each do |record|
      items << get_item(record)
    end

    return items
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_cost, quantity FROM items WHERE id = $1;
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]

    result = DatabaseConnection.exec_params(sql,sql_params)
    
    return get_item(result[0])
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_cost, quantity) VALUES ($1, $2, $3);
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]

    result = DatabaseConnection.exec_params(sql,sql_params)
    
    return nil
  end

  private

  def get_item(record)
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_f
      item.quantity = record['quantity'].to_i

      return item
  end

end