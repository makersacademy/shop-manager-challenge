require 'order'

class OrderRepository

  def all
    sql = "SELECT * FROM orders;"
    order_list = []
    orders = DatabaseConnection.exec_params(sql, [])
    orders.each do |row|
      order = Order.new
      order.id = row['id']
      order.customer_name = row['customer_name']
      order.order_date = row['order_date']
      order_list << order
    end
    order_list
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"
    params = [order.customer_name, order.order_date]
    result = DatabaseConnection.exec_params(sql, params)
  end

  def find(id)
    sql = "SELECT *
           FROM orders
           JOIN items_orders ON orders.id = items_orders.order_id
           JOIN items ON items_orders.item_id = items.id
           WHERE orders.id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    order = Order.new
    order.id = result.first['id']
    order.customer_name = result.first['customer_name']
    order.order_date = result.first['order_date']
    result.each do |row|
      item = Item.new
      item.id = row['item_id']
      item.name = row['name']
      item.price = row['price']
      order.items << item
    end
    order
  end

  def find_with_item(item)
    sql = "SELECT *
           FROM orders
           JOIN items_orders ON orders.id = items_orders.order_id
           JOIN items ON items_orders.item_id = items.id
           WHERE items.name = $1;"
    params = [item]
    order_list = []
    result = DatabaseConnection.exec_params(sql, params)
    order = Order.new
    result.each do |row|
      order.id = row['id']
      order.customer_name = row['customer_name']
      order.order_date = row['order_date']
      order_list << order
    end
    order_list
  end

end
