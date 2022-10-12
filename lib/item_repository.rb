require_relative '../lib/item'
require_relative '../lib/order'
require_relative '../lib/database_connection'

class ItemRepository
  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      set_item(record, item)

      items << item
    end

    items
  end

  def find(name)
    sql = 'SELECT * FROM items WHERE name = $1;'
    sql_params = [name]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    item = Item.new
    set_item(record, item)

    item
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def update_quantity(item)
    sql = 'UPDATE items SET quantity = $1 WHERE id = $2;'
    sql_params = [item.quantity, item.id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_order(order_customer_name)
    sql = 'SELECT items.id,
                  items.name,
                  items.unit_price,
                  items.quantity,
                  orders.id AS order_id,
                  orders.customer_name,
                  orders.order_date
           FROM items
           JOIN items_orders ON items_orders.item_id = items.id
           JOIN orders ON orders.id = items_orders.order_id
           WHERE orders.customer_name = $1;'
    sql_params = [order_customer_name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    order = Order.new

    set_order(order, result_set)

    result_set.each do |record|
      item = Item.new
      set_item(record, item)

      order.items << item
    end

    order
  end

  private

  def set_item(record, item)
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
  end

  def set_order(order, result_set)
    order.id = result_set.first['order_id']
    order.customer_name = result_set.first['customer_name']
    order.order_date = result_set.first['order_date']
  end
end
