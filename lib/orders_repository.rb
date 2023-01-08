require_relative "./orders"
require_relative "./items"
require_relative "./items_repository"

class OrdersRepository
  def all
    sql = "SELECT orders.customer_name, orders.date, items.name, items.price
  FROM items 
    JOIN orders_items ON orders_items.item_id = items.id
    JOIN orders ON orders_items.order_id = orders.id;"
    array = []
    result = DatabaseConnection.exec_params(sql, [])
    result.each do |record|
      order = Orders.new
      item = Items.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.date = record["date"]
      item.id = record["id"]
      item.name = record["name"]
      item.price = record["price"]
      order.items << item
      array << order
    end
    return array
  end

  def create(order, item_id)
    sql = "INSERT INTO orders (customer_name, date) VALUES ($1, $2) RETURNING id;"
    params = [order.customer_name, order.date]
    result = DatabaseConnection.exec_params(sql, params)
    order_id = result[0]["id"].to_i

    sql = "INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);"
    params = [order_id, item_id]
    DatabaseConnection.exec_params(sql, params)
  end
end
