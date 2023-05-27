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
end
