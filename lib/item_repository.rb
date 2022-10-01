require "item"

class ItemRepository
  def all
    items = []
    sql = "SELECT id, name, unit_price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |each_item|
      item = Item.new
      item.id = each_item["id"]
      item.name = each_item["name"]
      item.unit_price = each_item["unit_price"]
      item.quantity = each_item["quantity"]

     items << item
    end
    return items
  end
end