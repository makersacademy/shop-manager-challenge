require_relative 'item'

class ItemRepository
  def all
    sql = "SELECT * FROM items;"
    DatabaseConnection.exec_params(sql, []).map do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      item
    end
  end

  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);"
    DatabaseConnection.exec_params(sql, [item.name, item.unit_price, item.quantity])
  end
end
