require "orders"

class OrdersRepository
  def all
    orders = []
          
    sql = 'SELECT id, name, order_number, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    result_set.each do |record|
      order = Orders.new
  
      order.id = record['id']
      order.name = record['name']
      order.order_number = record['order_number']
      order.date = record['date']
  
      orders << order
      end
  
      return orders
    end
    
  def create(order)
    sql = 'INSERT INTO orders (name, order_number, date) VALUES($1, $2, $3)'
    sql_params = [order.name, order.order_number, order.date]
  
    DatabaseConnection.exec_params(sql, sql_params)
  
    return nil 
  end 
end