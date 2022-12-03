require_relative 'item'
require_relative 'order'

class ItemRepository
  def all
    sql = 'SELECT id, item_name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      item.orders = record['orders']
      
      items << item
    end
    return items
  end

  def find_with_orders(item_id)
    sql = 'SELECT items.id AS "id", items.item_name AS "item_name", orders.date AS "date", orders.customer_name AS "customer_name" FROM orders JOIN items ON orders.item_id = items.id WHERE items.id = $1;'
    params = [item_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    p result_set
    first_record = result_set[0]
    item = Item.new
    item.id = first_record["id"]
    item.item_name = first_record['item_name']
    item.orders = []

    result_set.each do |record|
      order = Order.new
      order.date = record['date']
      order.customer_name = record['customer_name']

      item.orders << order
    end
    return item
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES ($1, $2, $3);'   
    params = [item.item_name, item.unit_price, item.quantity]

    result_set = DatabaseConnection.exec_params(sql, params)
  end
end