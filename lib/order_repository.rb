require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders ORDER BY id;'
    results = DatabaseConnection.exec_params(sql, [])
    orders = []
    results.each do |record|
      orders << record_to_object(record)
    end
    orders
  end

  def create(order)
    sql = "INSERT INTO orders (date, customer_name) VALUES ($1, $2);"
    params = [order.date, order.customer_name]
    DatabaseConnection.exec_params(sql, params)
  end

  def find_with_items(id)
    sql = 'SELECT orders.id, orders.customer_name, date, items.id AS item_id, items.name AS item_name, price FROM orders
    JOIN items_orders
    ON items_orders.order_id = orders.id
    JOIN items 
    ON items_orders.item_id = items.id
    WHERE orders.id = $1;'
    
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    order = Order.new
    order.id = result.first['id']
    order.customer_name = result.first['customer_name']
    order.date = result.first['date']

    result.each do |record|
      item = Item.new
      item.id = record['item_id']
      item.name = record['item_name']
      item.price = record['price']
      order.items << item
    end
    order
  end

  private

  def record_to_object(record)
    object = Order.new
    object.id = record['id']
    object.customer_name = record['customer_name']
    object.date = record['date']
    object
  end
end
