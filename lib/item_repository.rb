require 'item'

class ItemRepository
  
  def all
    arr_items = []
    sql = 'SELECT id, name, unit_price, item_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, arr_items)

    result_set.each do |record|
      item = Item.new

      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_i
      item.item_quantity = record['item_quantity'].to_i
  
      arr_items << item
    end
  return arr_items
  end

  def find(id)
    sql_params = [id]
    sql = 'SELECT id, name, unit_price, item_quantity FROM items WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    item = Item.new

    record = result_set[0]

    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price'].to_i
    item.item_quantity = record['item_quantity'].to_i

    return item
  end
end