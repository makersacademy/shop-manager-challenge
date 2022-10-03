require_relative "../lib/database_connection.rb"
require_relative "../lib/order.rb"
require_relative "../lib/item.rb"

class OrderRepository

  def all
    query = "SELECT id, customer_name, order_date FROM orders;"
    params = []
    result = DatabaseConnection.exec_params(query, params)

    orders = []

    result.each { |record| 
      orders << object_to_order(record)
    }

    orders
  end

  def find_by_order(order_id)
    query = "SELECT orders.id, 
                    orders.customer_name,
                    orders.order_date,
                    items.id AS item_id,
                    items.price,
                    items.name 
                    FROM orders 
                      JOIN orders_items ON orders_items.order_id = orders.id 
                      JOIN items ON items.id = orders_items.item_id
                    WHERE orders.id = $1;"
    params = [order_id]
    result = DatabaseConnection.exec_params(query, params)

    order = object_to_order(result[0])

    result.each { |record|
      order.items  << object_to_item(record)
    }

    order
  end

  def create(order)
    query = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"
    params = [order.customer_name, order.order_date]
    result = DatabaseConnection.exec_params(query, params)
  end

  # Links order to the item that was ordered
  def link_to_item(order_id, item_id)
    query = "INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);"
    params = [order_id, item_id]
    result = DatabaseConnection.exec_params(query, params)
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
    item.name = record["name"]
    item.price = record["price"]

    item
  end
end
