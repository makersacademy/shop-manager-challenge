require_relative "../lib/item"
require_relative "../lib/order"
require_relative "../lib/database_connection"

class OrderRepository
  def all
    sql = "SELECT id, customer_name, order_date FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])
    all_orders_list = []

    result_set.each do |order|
      orders_all = Order.new
      orders_all.id = order["id"]
      orders_all.customer_name = order["customer_name"]
      orders_all.order_date = order["order_date"]
      all_orders_list << orders_all
    end
    return all_orders_list
  end

  def find_by_order(order_id)
    sql = "SELECT orders.id, 
        orders.customer_name,
        orders.order_date,
        items.id AS item_id,
        items.item_price,
        items.item_name 
        FROM orders 
        JOIN items_orders ON items_orders.order_id = orders.id 
        JOIN items ON items.id = items_orders.item_id
        WHERE orders.id = $1;"

    sql_params = [order_id]

    result = DatabaseConnection.exec_params(sql, sql_params)

    order = object_to_order(result[0])

    result.each do |record|
      order.items << object_to_item(record)
    end

    order
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1,$2);"
    sql_params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end

private

def object_to_order(record)
  order = Order.new
  order.id = record["id"]
  order.customer_name = record["customer_name"]
  order.order_date = record["order_date"]

  order
end

def object_to_item(record)
  item = Item.new
  item.id = record["item_id"]
  item.item_name = record["item_name"]
  item.item_price = record["item_price"]

  item
end
