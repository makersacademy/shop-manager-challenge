require_relative './item'

class ItemRepository

  def all
    sql = 'SELECT id, item_name, price, quantity, order_id
    FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.price = record['price']
      item.quantity = record['quantity']
      item.order_id = record['order_id']

      items << item 
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, price, quantity, order_id) 
    VALUES($1, $2, $3, $4);'
    sql_params = [item.item_name, item.price, item.quantity, item.order_id]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

end
