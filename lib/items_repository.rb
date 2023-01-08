require_relative "./items"

class ItemsRepository
  def all
    sql = "SELECT id, name, price, quantity FROM items;"
    result = DatabaseConnection.exec_params(sql, [])
    array = []
    result.each do |record|
      item = Items.new
      item.id = record["id"]
      item.name = record["name"]
      item.price = record["price"]
      item.quantity = record["quantity"]
      array << item
    end
    return array
  end

  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);"
    params = [item.name, item.price, item.quantity]
    result = DatabaseConnection.exec_params(sql, params)
  end
end
