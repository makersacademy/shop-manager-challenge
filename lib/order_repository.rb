require 'database_connection'
require 'order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    orders = []

    result_set.each do |record|
      orders << get_order(record)
    end

    return orders

  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;' 
    sql_params = [id]

    result = DatabaseConnection.exec_params(sql,sql_params)
    
    return get_order(result[0])

  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);
    sql = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.date, order.item_id]

    result = DatabaseConnection.exec_params(sql,sql_params)
    
    return nil
    
  end

  private
  
  def get_order(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id'].to_i

    return order
  end
end