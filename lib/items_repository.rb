require_relative 'items'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']
      items << item
    end
    items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']
    
    item
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

end 