require_relative "./database_connection"
require_relative "./item"

class ItemRepository
  def all
    sql = "SELECT * FROM items;"
    records = DatabaseConnection.exec_params(sql, [])
    
    items = []
    
    records.each do |record|
      item = Item.new
      item.id = record["id"]
      item.name = record["name"]
      item.unit_price = record["unit_price"]
      item.quantity = record["quantity"]
      items << item
    end
    
    items
  end
  
  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity)
    VALUES ($1, $2, $3);"
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end
end