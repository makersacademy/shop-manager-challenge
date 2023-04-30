require_relative 'item'
require_relative 'database_connection'

class ItemRepository
  def list
    # returns an array of Item objects
    query = 'SELECT id, name, unit_price, quantity FROM items;'
    results = DatabaseConnection.exec_params(query, [])
    return extract_items(results)
  end

  def create(item)
    # returns the id of the created object
    query1 = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(query1, params)

    query2 = 'SELECT max(id) FROM items'
    id = DatabaseConnection.exec_params(query2, []).to_a.first["max"]
    return id
  end

  def find_by_id(id)
    # returns an item object with given id
    query = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1'
    params = [id]
    entry = DatabaseConnection.exec_params(query, params).first
    item = Item.new(entry["name"], entry["unit_price"].to_i, entry["quantity"].to_i)
    item.id = entry["id"].to_i
    return item
  end

  def check_if_valid_id(id)
    # returns true or false based on if item has been found with a matching id
    return false unless id.to_s.match?(/^\d+$/)
    query = 'SELECT id FROM items WHERE id = $1;'
    params = [id]
    entries = DatabaseConnection.exec_params(query, params).to_a
    return entries.size == 1
  end

  private

  def extract_items(entries)
    # extracts an array of item objects from a DatabaseConnection results object
    items = []
    for entry in entries do
      item = Item.new(entry["name"], entry["unit_price"].to_i, entry["quantity"].to_i)
      item.id = entry["id"].to_i
      items << item
    end
    return items
  end
end
