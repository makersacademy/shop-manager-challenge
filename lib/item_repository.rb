require_relative "database_connection"
require_relative "item"

class ItemRepository

  def all
    query = "SELECT * FROM items"
    results = DatabaseConnection.exec_params(query, [])
    results.map do |result|
      Item.new([result["id"],
      result["name"],
      result["unit_price"],
      result["quantity"]])
    end
  end

  def create(item)
    query = "INSERT INTO items (name, unit_price, quantity) 
    VALUES ('#{item.name}', #{item.unit_price}, #{item.quantity})"
    DatabaseConnection.exec_params(query, [])
  end

end
