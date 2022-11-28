require_relative "order"
require_relative "item"

class OrderRepository
  def all
    sql = "SELECT id, customer, date FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record["id"]
      order.customer = record["customer"]
      order.date = record["date"]

      orders << order
    end

    return orders
  end

  def create(order)
    sql = "INSERT INTO orders (customer, date) VALUES ($1, $2);"
    sql_params = [order.customer, order.date]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find_with_items(id)
    sql = "SELECT orders.customer, orders.date, items.name 
    FROM orders
      JOIN items_orders ON items_orders.order_id = orders.id
      JOIN items ON items_orders.item_id = items.id
    WHERE orders.id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    order = Order.new

    order.customer = result.first["customer"]
    order.date = result.first["date"]

    result.each do |record|
      item = Item.new
      item.name = record["name"]

      order.items << item
    end

    return order
  end
end
