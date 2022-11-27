require_relative './order'
require_relative './item'

class OrderRepository

  def all
    sql = 'SELECT id, customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      orders << unpack_record(record)
    end
    return orders
  end

  def find(id)
    sql = 'SELECT id, customer, date FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    unpack_record(record)
  end

  def create(order, item)
    sql_orders = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
    params_orders = [order.customer, order.date]
    DatabaseConnection.exec_params(sql_orders, params_orders)
    sql_join = 'INSERT INTO items_orders (item_id, order_id)
                VALUES ($1, (SELECT MAX(id) FROM orders));'
    params_join = [item.id]
    DatabaseConnection.exec_params(sql_join, params_join)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(order)
    sql = 'UPDATE orders SET customer = $1, date = $2 WHERE id = $3;'
    params = [order.customer, order.date, order.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_with_item(order_id)
    sql = 'SELECT orders.id,
                  orders.customer,
                  orders.date,
                  items.id AS "item_id",
                  items.name,
                  items.price,
                  items.quantity
          FROM orders
          JOIN items_orders ON items_orders.order_id = orders.id
          JOIN items ON items_orders.item_id = items.id
          WHERE orders.id = $1;'
    params = [order_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    order = Order.new
    order.id = record['id'].to_i
    order.customer = record['customer']
    order.date = record['date']

    result_set.each do |record|
      item = Item.new
      item.id = record['item_id'].to_i
      item.name = record['name']
      item.price = record['price'].to_f
      item.quantity = record['quantity'].to_i
      order.items << item
    end
    return order
  end

  private

  def unpack_record(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer = record['customer']
    order.date = record['date']
    return order
  end
end
