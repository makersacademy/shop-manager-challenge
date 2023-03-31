require "item.rb"

class ItemRepository
  def all
    items = []
    sql = "SELECT id, name, unit_price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      item = Item.new
      item.id = record["id"]
      item.name = record["name"]
      item.unit_price = record["unit_price"]
      item.quantity = record["quantity"]

      items << item
    end

    return items
  end

  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);"
    params = [item.name, item.unit_price, item.quantity]
    
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end