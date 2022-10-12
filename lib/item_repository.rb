#would be good to update each item when an order is placed to reduce the quanitity 

require_relative './item'
require_relative './database_connection'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items << item
    end
    
    return items
  end

  def create(item)
    sql = 'INSERT INTO 
    items (name, unit_price, quantity) 
    VALUES($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end


  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;' 
    sql_params = [id] 

    result_set = DatabaseConnection.exec_params(sql,sql_params) #sending both the sql and params
    
    record = result_set[0]
    

    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    return item
  end
  

  def update(item)
    sql = "UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;"
    sql_params = [item.name, item.unit_price, item.quantity, item.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end