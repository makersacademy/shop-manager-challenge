require_relative 'database_connection'
require_relative 'item'

class ItemRepository
  def all
    sql = "SELECT id, name, unit_price, stock_quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record["id"]
      item.name = record["name"]
      item.unit_price = record["unit_price"]
      item.stock_quantity = record['stock_quantity']
      items << item
    end
    return items
  end
end