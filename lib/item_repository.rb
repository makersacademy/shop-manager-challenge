require_relative "./database_connection"
require_relative "./item"

class ItemRepository
  def all
    sql = "SELECT * FROM items;"
    records = DatabaseConnection.exec_params(sql, [])
    records.map { |record| convert_record_to_item(record) }
  end
  
  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity)
    VALUES ($1, $2, $3);"
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end
  
  private
  
  def convert_record_to_item(record)
    item = Item.new
    item.id = record["id"]
    item.name = record["name"]
    item.unit_price = record["unit_price"]
    item.quantity = record["quantity"]
    item
  end
end
