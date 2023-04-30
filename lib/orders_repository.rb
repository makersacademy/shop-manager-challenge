require_relative 'orders'

class OrdersRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, order_name, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []
    result_set.each do |record|
      order = Orders.new
      order.order_name = record['order_name']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
    

      orders << order
    # Returns an array of User objects.
    end
  return orders
  end

  def find(id)
  #   # Executes the SQL query
    sql = 'SELECT id, order_name, customer_name, order_date FROM orders WHERE id = $1;' 
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  
    record = result_set[0]

    order = Orders.new
    order.order_name = record['order_name']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']

    return order
  end

  def create(orders)
    # Executes SQL query
    sql = 'INSERT INTO orders (order_name, customer_name, order_date) VALUES($1, $2, $3);'
    sql_params = [orders.order_name, orders.customer_name, orders.order_date]
    DatabaseConnection.exec_params(sql, sql_params)
    # Doesn't need to return anything (only creates a record)
    return nil
   end
   
   def delete(id)
    # Executes the SQL
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    # Returns nothing (only deletes the record)
    return nil
   end
end