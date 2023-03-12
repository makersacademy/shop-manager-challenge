require_relative 'item'

class ItemRepository
  def all
    items = []

    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price'].to_i
      item.quantity = record['quantity'].to_i
      items << item
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1';
    result_set = DatabaseConnection.exec_params(sql, [id])
    
    item = Item.new
    item.id = result_set[0]['id'].to_i
    item.name = result_set[0]['name']
    item.price = result_set[0]['price'].to_i
    item.quantity = result_set[0]['quantity'].to_i

    return item
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    result_set = DatabaseConnection.exec_params(sql, [item.name, item.price, item.quantity])

    return item
  end
end
		