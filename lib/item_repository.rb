require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
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
end
