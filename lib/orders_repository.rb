require_relative "./orders"
require_relative "./items"
require_relative "./items_repository"

class OrdersRepository
  def all
    sql = "SELECT orders.customer_name, orders.date, items.name, items.price
  FROM items 
    JOIN orders_items ON orders_items.item_id = items.id
    JOIN orders ON orders_items.order_id = orders.id;"
    arr = []
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
      arr << order
    end
    return arr
  end

  def create(order, item)
    sql = "INSERT INTO orders (name, date) VALUES ($1, $2);"
    params = [order.name, order.date]
    DatabaseConnection.exec_params(sql, params)

    sql = "INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);"
    params = [order.id, item.id]
    DatabaseConnection.exec_params(sql, params)
  end
end

# repo = Order.new
# o = repo.create(order)
# o.name = "orhan"
# o.date = "27.01.22"
# o.items << item
# item = Items.new
# item.name = ""
#item = Items.new
