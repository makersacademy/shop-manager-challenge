require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items ORDER BY id;'
    results = DatabaseConnection.exec_params(sql, [])
    
    items = []
    results.each do |result|
      item = Item.new
      item.id = result['id']
      item.name = result['name']
      item.price = result['price']
      item.quantity = result['quantity']
      
      items << item
    end
    
    return items
  end
  
  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);'
    DatabaseConnection.exec_params(sql, [item.name, item.price, item.quantity])
  end
  
  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    
    item = Item.new
    item.id = result.first['id']
    item.name = result.first['name']
    item.price = result.first['price']
    item.quantity = result.first['quantity']
    
    return item
  end
  
  def update_quantity(id)
    sql = 'UPDATE items SET quantity = quantity - 1 WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
  end
end
