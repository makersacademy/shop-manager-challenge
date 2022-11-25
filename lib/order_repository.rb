require_relative './order'

class OrderRepository
  def all 
    orders = []

    sql = 'SELECT id, customer_name, date_placed FROM orders;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.each do |record|
      orders << record_to_object(record)
    end
    return orders
  end

  def create(order)

    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date_placed]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  private 

  def record_to_object(record)
    order = Order.new 
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    
    return order
  end
end