require_relative "order"

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql,[])
    orders = []
    result_set.each do |record| 
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      orders << order 
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders(customer_name, date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
end
