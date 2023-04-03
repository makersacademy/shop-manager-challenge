require_relative 'database_connection'
require_relative 'shop_item'

class ShopRepository
  def all_items
    sql = 'SELECT * FROM items'
    result = DatabaseConnection.exec_params(sql, [])
    output = []

    result.each do |line| 
      item = ShopItem.new
      item.id = line["id"]; item.name = line["name"]
      item.price = line["price"]; item.qty = line["qty"]
      output << item
    end
    return output
  end

  def single_item(id)
    params = [id]; sql = 'SELECT * FROM items WHERE id=$1'
    result = DatabaseConnection.exec_params(sql, params)

    item = ShopItem.new
    item.id = result.first["id"]; item.name = result.first["name"]
    item.price = result.first["price"].to_i; item.qty = result.first["qty"].to_i

    return item
  end

  def create_item(item)
    params = [item.name, item.price, item.qty]
    sql = 'INSERT INTO items (name, price, qty) VALUES ($1, $2, $3);'
    result = DatabaseConnection.exec_params(sql, params)
    return true
  end
end
