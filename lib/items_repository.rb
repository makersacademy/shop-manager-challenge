require_relative "item"

class ItemsRepository
  def all
    sql = 'SELECT id, item_name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    output = []
    result_set.each{|object|
      item = Item.new
      item.id = object['id']
      item.item_name = object['item_name']
      item.price = object['price']
      item.quantity = object['quantity']
      output << item
      }
     return output
  end

  def find(id)
    sql = 'SELECT id, item_name, price, quantity  FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    item = Item.new
    result_set.each{|object|
      item.id = object['id']
      item.item_name = object['item_name']
      item.price = object['price']
      item.quantity = object['quantity']
      }
      return item
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, price, quantity) VALUES($1, $2, $3);'
    params = [item.item_name, item.price, item.quantity]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def update(item)
    sql = 'UPDATE items SET item_name = $1, price = $2, quantity = $3 WHERE id = $4;'
    params = [item.item_name, item.price, item.quantity, item.id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def delete(item)
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [item.id]
    DatabaseConnection.exec_params(sql, params)
  end
end