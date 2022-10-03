require_relative '../lib/item'
require_relative '../lib/database_connection'

class ItemRepository

  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |record|
      items << itemise(record)
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]
        
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def itemise(record)
    item = Item.new
    item.id = record["id"]
    item.name = record["name"]
    item.price = record["price"]
    item.quantity = record["quantity"]
        
    return item
  end
end
