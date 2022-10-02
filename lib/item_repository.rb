require_relative "item"

class ItemRepository
  def all
    sql = 'SELECT id, item_name, unit_price, quantity, order_id FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])
    items = []
    result_set.each do |record| 
      item = Item.new
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      item.order_id = record['order_id']
      item.id = record['id']

      items << item 
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES($1, $2, $3, $4);'
    sql_params = [item.item_name, item.unit_price, item.quantity, item.order_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
