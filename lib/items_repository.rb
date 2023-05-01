require_relative 'items'

class ItemsRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []
    result_set.each do |record|
      item = Items.new
      item.item_name = record ['item_name']
      item.item_price = record['item_price']
      item.item_quantity = record['item_quantity']
    

      items << item
    # Returns an array of User objects.
    end
  return items
  end
  
   def find(id)
  #   # Executes the SQL query
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items WHERE id = $1;' 
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  
    record = result_set[0]

      item = Items.new
      item.item_name = record ['item_name']
      item.item_price = record['item_price']
      item.item_quantity = record['item_quantity']

    return item
  end

  def create(items)
    # Executes SQL query
    sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES($1, $2, $3);'
    sql_params = [items.item_name, items.item_price, items.item_quantity]
    DatabaseConnection.exec_params(sql, sql_params)
    # Doesn't need to return anything (only creates a record)
    return nil
   end

   def delete(id)
    # Executes the SQL
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    # Returns nothing (only deletes the record)
    return nil
   end
end