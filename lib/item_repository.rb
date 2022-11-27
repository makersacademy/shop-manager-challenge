require_relative 'item'
require_relative 'order'
require_relative 'item_order'

class ItemRepository

def all 
  sql = 'SELECT id, name, price, quantity FROM items;'
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

  items
end

def create(item)
  sql = 'INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);'
  sql_params = [item.name, item.price, item.quantity]
  result_set = DatabaseConnection.exec_params(sql, sql_params)
end

def find_by_order(order_id)
  sql = 'SELECT items.id, items.name, items.price, items.quantity 
            FROM items
              JOIN items_orders ON items_orders.item_id = items.id
              JOIN orders ON items_orders.order_id = orders.id
            WHERE orders.id = $1;'
  sql_params = [order_id]
  result_set = DatabaseConnection.exec_params(sql, sql_params)

end

end