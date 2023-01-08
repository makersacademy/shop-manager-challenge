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

  def create

  end

end
