require_relative './order'
class OrderRepo
  def all 
    orders = []
    sql = 'SELECT customer, date, order_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record| 
      order = Order.new 
      order.customer = record['customer']
      order.date = record['date']
      order.order_id = record['order_id']
      orders << order
    end 
    return orders
end
  def find(order_id)
    sql = 'SELECT customer, date FROM orders WHERE order_id = $1;'
    sql_params = [order_id]
    
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
 
    order = Order.new 
    order.order_id = record['order_id']
    order.customer = record['customer']
    order.date = record['date']

    return order
  end 
  def create(order)
    sql = 'INSERT INTO orders (customer, date, order_id) VALUES($1, $2, $3);'
    sql_params = [order.customer, order.date, order.order_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end 
  def delete(order_id)
    sql = 'DELETE FROM orders WHERE order_id = $1'
    sql_params = [order_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
end  
end 