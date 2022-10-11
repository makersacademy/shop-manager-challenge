require_relative '../lib/order.rb'
require_relative '../lib/item.rb'
require_relative '../lib/database_connection.rb'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      orders << order
    end

    orders
  end

  def find(id)
    sql = 'SELECT * FROM orders WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']

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

    item.id = result_set.first['id']
    item.name = result_set.first['name']
    item.unit_price = result_set.first['unit_price']
    item.quantity = result_set.first['quantity']

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      item.orders << order
    end

    item
  end
end
