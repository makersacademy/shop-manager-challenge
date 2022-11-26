require_relative './order'

class OrderRepository

  def all

    sql = 'SELECT id, customer_name, date FROM orders;'
   
    result_set = DatabaseConnection.exec_params(sql,[])

    all_orders = []

    result_set.each do |record|

      all_orders << record_to_object(record)
      
    end 

    return all_orders

    # Returns an array of Order objects.

  end 

  def create(order)

    sql = 'INSERT INTO orders (customer_name, date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date]

    DatabaseConnection.exec_params(sql,sql_params)

  end 

  private

  def record_to_object(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name'] 
    order.date = record['date']

    return order
  end

end 
