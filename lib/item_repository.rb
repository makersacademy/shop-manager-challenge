require_relative "item"
require_relative "database_connection"

class ItemRepository
  def all
    sql_query = "SELECT id, name, unit_price, quantity FROM items;"
    query_result = DatabaseConnection.exec_params(sql_query, [])

    items = []
    query_result.each do |record|
      item = Item.new
      item.id = record["id"].to_i
      item.name = record["name"]
      item.unit_price = record["unit_price"].to_f.round(2)
      item.quantity = record["quantity"].to_i
      items << item
    end
    return items
  end

  def create(item)
    sql_query = "INSERT INTO items (id, name, unit_price, quantity) VALUES ($1, $2, $3, $4)"
    params = [item.id, item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql_query, params)
  end
end