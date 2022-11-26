require_relative './item'
require_relative './database_connection'

class ItemRepository
  def all
    result_set = DatabaseConnection.exec_params(
    'SELECT id, name, unit_price, stock_count FROM items;', [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.stock_count = record['stock_count']

      items << item
    end 
    items
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, name, unit_price, stock_count FROM items WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    record = result_set[0]

    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.stock_count = record['stock_count']

    item
  end

  def create(item)
    sql = 'INSERT INTO items(name, unit_price, stock_count) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.stock_count]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end
end
