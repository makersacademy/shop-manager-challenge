require_relative "item"

class ItemRepository
  def all
    sql = "SELECT * FROM items"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |result|
      item = Item.new
      item.id = result['id'].to_i
      item.name = result['name']
      item.unit_price = result['unit_price'].to_f
      item.quantity = result['quantity'].to_i
      items << item
    end
    return items;
  end

  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)"
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end
end