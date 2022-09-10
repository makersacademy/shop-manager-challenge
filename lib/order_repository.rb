require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders'
    result = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    result.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer = record['customer']
      order.date = record['date']
      orders << order
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2)'
    params = [order.customer, order.date]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_with_items(id)
    sql = 'SELECT orders.customer, orders.date, items.name
    FROM orders
      JOIN items_orders ON items_orders.order_id = orders.id
      JOIN items ON items.id = items_orders.item_id
    WHERE orders.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    
    customer = result.first['customer']
    date = result.first['date']
    
    items = []
    result.each do |record|
      items << record['name']
    end

    return [customer, date, items]
  end
end