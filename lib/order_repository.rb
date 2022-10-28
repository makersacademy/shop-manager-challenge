require_relative './item'
require_relative './order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      orders << order
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders(customer_name, order_date) VALUES ($1, $2);'
    sql_params = [order.customer_name, order.order_date]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def search_orders_by_item(item_id)
    sql = 'SELECT orders.id, items.item_name
            FROM orders 
            JOIN orders_items ON orders_items.order_id = orders.id
            JOIN items ON orders_items.item_id = items.id
          WHERE items.id = $1;'

    sql_params = [item_id]
    
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    first_record = result_set[0]

    order = record_to_order_object(first_record)

    result_set.each do |record|
      order.items << record_to_order_object(record)
    end

    return order
  end

private

  def record_to_order_object(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']

    return order
  end

  def record_to_item_object(record)
    item = Item.new
    item.id = record["id"]
    item.item_name = record["item_name"]
    item.item_price = record["item_price"]
    item.item_quantity = record["item_quantity"]

    return tag
  end
end
