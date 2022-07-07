require_relative "./item"

class ItemRepository
  def all
    query = "SELECT * FROM items;"
    result_set = DatabaseConnection.exec_params(query, [])
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record["id"].to_i
      item.name = record["name"]
      item.price = record["price"]
      items << item
    end
    items
  end

  def create(item)
    query = "INSERT INTO items (name, price) VALUES ($1, $2);"
    params = [item.name, item.price]

    DatabaseConnection.exec_params(query, params)
  end
end
