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
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      orders.push(order)
    }

    orders
  end

  def view_order(order_id)
    sql = '
            SELECT item_name, unit_price, items_orders.order_quantity, orders.customer_name, orders.order_date
            FROM items
            JOIN items_orders ON items_orders.item_id = items.id
            JOIN orders ON items_orders.order_id = orders.id
            WHERE items_orders.order_id = $1;
          '
    result_set = DatabaseConnection.exec_params(sql, [order_id])

    ordered_items = []
    order_details = Order.new
    order_details.customer_name = result_set.first['customer_name']
    order_details.order_date = result_set.first['order_date']

    total_price = 0
    result_set.each{
      |record|
      ordered_item = OrderedItem.new
      ordered_item.item_name = record['item_name']
      ordered_item.order_quantity = record['order_quantity']
      price = (record['unit_price'].to_i * record['order_quantity'].to_i)
      total_price += price
      ordered_item.price = price.to_s
      ordered_items.push(ordered_item)
    }

    [order_details, ordered_items, total_price]
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

  def create(order_details, item_ids, item_quantities)

    sql = '
            INSERT INTO orders (customer_name, order_date)
            VALUES ($1, $2);
          '
    DatabaseConnection.exec_params(sql, [order_details.customer_name, order_details.order_date])

    sql = '
            SELECT orders.id
            FROM orders
            WHERE customer_name = $1 AND order_date = $2;
          '
    order = DatabaseConnection.exec_params(sql, [order_details.customer_name, order_details.order_date])[0]

    item_ids.each_with_index {
      |item_id, index|

      sql = '
              SELECT *
              FROM items
              WHERE items.id = $1;
            '
      ordered_item = DatabaseConnection.exec_params(sql, [item_id])[0]

      new_quantity = ordered_item['quantity'].to_i - item_quantities[index].to_i

      sql = '
              UPDATE items
              SET quantity = $1
              WHERE items.id = $2;
            '
      DatabaseConnection.exec_params(sql, [new_quantity, item_id])

      sql = '
            INSERT INTO items_orders (item_id, order_id, order_quantity)
            VALUES ($1, $2, $3);
          '

      DatabaseConnection.exec_params(sql, [ordered_item['id'], order['id'], item_quantities[index]])
    }
  end

end