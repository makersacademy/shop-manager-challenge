require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date FROM orders;'
    results = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    results.each do |result|
      order = Order.new
      order.customer_name = result['customer_name']
      order.date = result['date']
      
      orders << order
    end
    
    return orders
  end
  
  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES($1, $2) RETURNING id;'
    result = DatabaseConnection.exec_params(sql, [order.customer_name, order.date])
    order_id = result.first['id']
    
    order.items.each do |item|
      sql = 'INSERT INTO items_orders (item_id, order_id) VALUES($1, $2);'
      result = DatabaseConnection.exec_params(sql, [item, order_id])
    end
  end
end
