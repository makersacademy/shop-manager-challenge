require_relative 'item'
require_relative 'hash_values_to_integers'

class ItemRepository
  def all
    query = <<~SQL
      SELECT * FROM items
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Item.new(hash_values_to_integers(_1)) }
  end

  def create(item)
    query = <<~SQL
      INSERT INTO items (name, unit_price, quantity) 
      VALUES ($1, $2, $3)
    SQL
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(query, params)
  end
end
