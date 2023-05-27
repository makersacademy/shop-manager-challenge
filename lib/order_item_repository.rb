require_relative './order_item'
require 'bigdecimal'

class OrderItemRepository
  def all
    order_items = []

    query = <<-SQL
      SELECT orders.id AS order_id, orders.customer_name, orders.order_date,
             items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN orders ON orders.id = order_items.order_id
      JOIN items ON items.id = order_items.item_id
    SQL

    result_set = DatabaseConnection.exec_params(query, [])

    result_set.each do |row|
      order = Order.new
      order.id = row['order_id'].to_i
      order.customer_name = row['customer_name']
      order.order_date = row['order_date']

      item = Item.new
      item.id = row['item_id'].to_i
      item.name = row['name']
      item.unit_price = BigDecimal(row['unit_price'])
      item.quantity = row['quantity'].to_i

      order_item = OrderItem.new
      order_item.order = order
      order_item.item = item

      order_items << order_item
    end

    return order_items
  end

  def find(order_id)
    order_items = []

    query = <<-SQL
      SELECT items.id AS item_id, items.name, items.unit_price, items.quantity
      FROM order_items
      JOIN items ON items.id = order_items.item_id
      WHERE order_items.order_id = $1
    SQL

    params = [order_id]

    result_set = DatabaseConnection.exec_params(query, params)

    result_set.each do |row|
      item = Item.new
      item.id = row['item_id']
      item.name = row['name']
      item.unit_price = BigDecimal(row['unit_price'])
      item.quantity = row['quantity'].to_i

      order_item = OrderItem.new
      order_item.order_id = order_id
      order_item.item = item

      order_items << order_item
    end

    return order_items
  end

  def create(order_id, item_id)
    sql = 'INSERT INTO order_items (order_id, item_id) VALUES ($1, $2);'
    params = [order_id, item_id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
