require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items'
    result = DatabaseConnection.exec_params(sql, [])
    
    items = []
    result.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_i
      item.quantity = record['quantity'].to_i
      items << item
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)'
    params = [item.name, item.unit_price, item.quantity]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
end