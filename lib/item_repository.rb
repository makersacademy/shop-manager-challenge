require '../lib/item'

class ItemRepository
  def all
    query = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(query, [])
    items = []
    result.each do |item|
      new_item = Item.new
      new_item.id = item['id']
      new_item.name = item['name']
      new_item.unit_price = item['unit_price']
      new_item.quantity = item['quantity']
      items << new_item
    end
    return items
  end

  def create(name, unit_price, quantity)
    query = 'INSERT INTO items (id, name, unit_price, quantity) VALUES($1, $2, $3, $4);'
    id = self.all.length + 1
    params = [id, name, unit_price, quantity]
    DatabaseConnection.exec_params(query, params)
  end
end

