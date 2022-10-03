require_relative './item.rb'

class ItemRepository

  def all
    sql = 'SELECT name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []
    
    result_set.each do |record|
      item = Item.new
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']
      items << item
    end
    return items
  end
  # Returns an array of item objects.

  def find(id)
    sql = 'SELECT name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    item = Item.new
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']
    return item
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def update(quantity)
    quantity -= 1
    sql = 'UPDATE items SET quantity = $1;'
    params = [quantity.to_s]
    DatabaseConnection.exec_params(sql, params)
  end
end
