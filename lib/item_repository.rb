require_relative 'item'
require_relative 'order'

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
    return items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']
    return item
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def find_orders_with_item(id)
    sql = 'SELECT
            items.id AS item_id,
            items.name,
            items.price,
            items.quantity,
            orders.id as order_id,
            orders.customer_name,
            orders.date
          FROM
            items
            JOIN items_orders ON items_orders.item_id = items.id
            JOIN orders ON items_orders.order_id = orders.id
          WHERE
            items.id = $1;'

    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    item = Item.new

    item.id = result.first['item_id']
    item.name = result.first['name']
    item.price = result.first['price']
    item.quantity = result.first['quantity']

    result.each do |record|
      order = Order.new
      order.id = record['order_id']
      order.customer_name = record['customer_name']
      order.date = record['date']

      item.orders << order
    end

  return item

  end
end