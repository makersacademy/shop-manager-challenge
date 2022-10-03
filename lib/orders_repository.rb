require_relative 'orders'

class OrderRepository
  def all
    orders = []
    sql = 'SELECT id, customer_name, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      orders << record_to_order_object(record)
    end
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    sql_params = [order.customer_name, order.date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    nil
  end

  private
  
  def record_to_order_object(record)
    order = Order.new

    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']

    order
  end
end