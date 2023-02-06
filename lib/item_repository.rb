require_relative 'item'
require_relative 'database_connection'

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

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]
  
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
  
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    
    return item
  end
end