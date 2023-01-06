require_relative "./item"
require_relative "./database_connection"

class ItemRepository
  def all
    sql = "SELECT id, name, price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end
    return items
  end

  def find(id)
    sql = "SELECT id, name, price, quantity FROM items WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']

    return item
  end

  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);"
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def update(item)
    sql = "UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;"
    params = [item.name, item.price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def delete(item_id)
    sql = "DELETE FROM items WHERE id = $1;"
    params = [item_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
