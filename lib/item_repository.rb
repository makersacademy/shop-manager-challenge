require_relative 'items'
require_relative 'order'
class ItemRepository
  def all_items
    sql = 'SELECT * FROM items'
    repo = DatabaseConnection.exec_params(sql, [])
    items = []
    repo.each do |each_item|
      item = Item.new
      item.id = each_item['id']
      item.name = each_item['name']
      item.unit_price = each_item['unit_price']
      item.quantity = each_item['quantity']
      items << item
    end
    items
  end

  def add_item(name, unit_price, quantity)
    sql =
      "INSERT INTO items (name, unit_price, quantity)
    VALUES ('#{name}','#{unit_price}','#{quantity}');"
    repo = DatabaseConnection.exec_params(sql, [])
  end

  def all_orders
    # sql = 'SELECT * FROM orders'
    sql =
      'SELECT orders.id, orders.cust_name, orders.date, items.name AS product_name FROM orders JOIN items ON orders.product_id = items.id'
    repo = DatabaseConnection.exec_params(sql, [])
    orders = []
    repo.each do |each_order|
      order = Order.new
      order.id = each_order['id']
      order.cust_name = each_order['cust_name']
      order.product_name = each_order['product_name']
      order.date = each_order['date']
      orders << order
    end
    orders
  end

  def add_order(cust_name, product_name, product_id, date)
    sql =
      "INSERT INTO orders (cust_name, product_name, product_id, date)
  VALUES ('#{cust_name}','#{product_name}','#{product_id}','#{date}');"
    repo = DatabaseConnection.exec_params(sql, [])
  end
end
