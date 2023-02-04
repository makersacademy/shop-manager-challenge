require_relative 'order'
require_relative 'ordered_item'

class OrderRepository
  def all
    sql = '
            SELECT *
            FROM orders;
          '
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each{
      |record|
      order = Order.new
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      orders.push(order)
    }

    orders
  end

  def view_order(order_id)
    sql = '
            SELECT item_name, unit_price, items_orders.order_quantity
            FROM items
            JOIN items_orders ON items_orders.item_id = items.id
            JOIN orders ON items_orders.order_id = orders.id
            WHERE items_orders.order_id = $1;
          '
    result_set = DatabaseConnection.exec_params(sql, [order_id])

    ordered_items = []

    result_set.each{
      |record|
      ordered_item = OrderedItem.new
      ordered_item.item_name = record['item_name']
      ordered_item.order_quantity = record['order_quantity']
      ordered_item.price = (record['unit_price'].to_i * record['order_quantity'].to_i).to_s
      ordered_items.push(ordered_item)
    }

    ordered_items
  end

  def find_date(order_id)
    sql = '
            SELECT order_date
            FROM orders
            WHERE orders.id = $1;
          '
    record = DatabaseConnection.exec_params(sql, [order_id])[0]

    return record['order_date']
  end
end