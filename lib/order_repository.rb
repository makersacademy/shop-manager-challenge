require_relative 'database_connection'
require_relative 'order'
require_relative 'shop_item'

class OrderRepository 
  def all_orders
    sql = 'SELECT * FROM orders'
    result = DatabaseConnection.exec_params(sql, [])
    output = []

    result.each do |line| 
      item = Order.new
      item.id = line["id"]; item.customer = line["customer"]
      item.date_of_order = line["date_of_order"]
      output << item
    end
    return output
  end

  def number_of_orders
    sql = 'SELECT * FROM orders'
    result = DatabaseConnection.exec_params(sql, [])
    output = []
    result.each { |item| output << item }
    return output.length
  end

  def single_order(id)
    params = [id]; sql = 'SELECT * FROM orders WHERE id=$1'
    result = DatabaseConnection.exec_params(sql, params)

    item = Order.new
    item.id = result.first["id"]; item.customer = result.first["customer"]
    item.date_of_order = result.first["date_of_order"]
    return item
  end

  def single_order_with_items(id)
    customer_order = single_order(id)
    sql = 'SELECT items.id, items.name FROM items
           JOIN items_orders ON items_orders.item_id = items.id
           JOIN orders ON items_orders.order_id = orders.id
           WHERE orders.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    result.each { |item| customer_order.order_items << item["name"] }
    return customer_order
  end

  def create_order(order)
    params = [order.customer, order.date_of_order]
    sql = 'INSERT INTO orders (customer, date_of_order) VALUES ($1, $2);'
    result = DatabaseConnection.exec_params(sql, params)

    order.order_items.each do |pair|
      params = [pair[0], pair[1]]
      sql = 'INSERT INTO items_orders (order_id, item_id) VALUES ($1, $2);'
      result = DatabaseConnection.exec_params(sql, params)
    end
    return true
  end
end
