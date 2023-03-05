require_relative "./item"

class ItemRepository
  def all
    items = []
    sql = "SELECT * FROM items;"
    result = DatabaseConnection.exec_params(sql, [])

    result.each do |record|
      item = Item.new
      item.id = record["id"]
      item.item_name = record["item_name"]
      item.price = record["price"]
      item.quantity = record["quantity"]
      item.order_id = record["order_id"]

      items << item
    end
    items
  end

  def find(id)
    sql =
      "SELECT id, item_name, price, quantity, order_id FROM items WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    item = Item.new
    item.id = record["id"]
    item.item_name = record["item_name"]
    item.price = record["price"]
    item.quantity = record["quantity"]
    item.order_id = record["order_id"]

    return item
  end

  def create(item)
    sql =
      "INSERT INTO items (item_name, price, quantity, order_id) VALUES ($1, $2, $3, $4);"
    params = [item.item_name, item.price, item.quantity, item.order_id]
    result = DatabaseConnection.exec_params(sql, params)
  end
end
