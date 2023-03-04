require_relative "item"

class ItemRepository
  
  def all
    items = []
    sql = 'SELECT id, name, price, quantity FROM items;'
    results = DatabaseConnection.exec_params(sql, [])

    results.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price'].to_f
      item.quantity = record['quantity'].to_i
      items << item
    end
    items
  end

  def create(item) # item is an instance of Item class
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end
end
