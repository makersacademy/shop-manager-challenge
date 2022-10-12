require_relative '../lib/order'
require_relative '../lib/item'
require_relative '../lib/database_connection'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      set_order(record, order)
      orders << order
    end

    orders
  end

  def find(customer_name)
    sql = 'SELECT * FROM orders WHERE customer_name = $1;'
    sql_params = [customer_name]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    order = Order.new
    set_order(record, order)

    order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.order_date]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_item(item_name)
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
           WHERE items.name = $1;'
    sql_params = [item_name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    item = Item.new

    set_item(item, result_set)

    result_set.each do |record|
      order = Order.new
      set_order(record, order)

      item.orders << order
    end

    item
  end

  def set_order(record, order)
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
  end

  def set_item(item, result_set)
    item.id = result_set.first['id']
    item.name = result_set.first['name']
    item.unit_price = result_set.first['unit_price']
    item.quantity = result_set.first['quantity']
  end
end
