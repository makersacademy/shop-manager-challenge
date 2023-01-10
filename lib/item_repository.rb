require_relative "item"

class ItemRepository
  def all
    sql = 'SELECT id, item_name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.unit_price = record['unit_price'].to_i
      item.quantity = record['quantity'].to_i
      items << item
    end
    return items
  end
end
