require_relative './item'
require_relative './database_connection'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']
      all_items << item
    end
    return all_items
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_param = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_param)
  end
end