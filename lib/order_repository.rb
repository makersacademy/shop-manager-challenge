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

    sql = 'SELECT items.name
           FROM items
           JOIN items_orders ON items_orders.item_id = items.id
           JOIN orders ON items_orders.order_id = orders.id
           WHERE orders.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    
    result.each do |item|
      customer_order.order_items << item["name"]
    end

    return customer_order
  end
end

