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
    order.id = new_order_id
    sql = "INSERT INTO orders (id, date, customer_name) VALUES ($1, $2, $3);"
    params = [order.id, order.date, order.customer_name]
    DatabaseConnection.exec_params(sql, params)

    order.items.each do |item|
      sql_items = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)'
      params_items = [item.id, order.id]
      DatabaseConnection.exec_params(sql_items, params_items)
    end
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

  def new_order_id
    last_id_query = 'SELECT MAX(id) FROM orders;'
    last_id_result = DatabaseConnection.exec_params(last_id_query, [])

    new_id = last_id_result.first['max'].to_i
    new_id + 1
  end
end
