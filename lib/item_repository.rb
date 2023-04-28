require_relative 'item'

class ItemRepository
  def list
    # query = 'SELECT id, name, unit_price, quantity FROM items;'
    # returns an array of Item objects
    query = 'SELECT id, name, unit_price, quantity FROM items;'
    results = DatabaseConnection.exec_params(query, [])
    items = []
    for entry in results do
      item = Item.new
      item.id = entry["id"].to_i
      item.name = entry["name"]
      item.unit_price = entry["unit_price"].to_i
      item.quantity = entry["quantity"].to_i
      items << item
    end
    return items
  end

  def create(item)
    # query_1 = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    # params = [item.name, item.unit_price, item.quantity]
    # returns the id of the created object
    query_1 = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(query_1, params)

    query_2 = 'SELECT max(id) FROM items'
    result = DatabaseConnection.exec_params(query_2, [])
    return result.to_a.first["max"]
  end

  
end
