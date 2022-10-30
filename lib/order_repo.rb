require_relative "order"

class OrderRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, item_ordered, date_order FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.item_ordered = record['item_ordered']
    order.date_order = record['date_order']

    orders << order
    end 
    orders
  end

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   sql = 'SELECT id, customer_name, item_ordered, date_order FROM orders WHERE id = $1;'
  #   params = [id]
  #   result_set = DatabaseConnection.exec_params(sql, params)

  #   record = result_set[0]

  #   order = Order.new
  #   order.id = record['id']
  #   order.customer_name = record['customer_name']
  #   order.item_ordered = record['item_ordered']
  #   order.date_order = record['date_order']

  #   # Returns a single Student object.
  #   return order 
  # end

  # # Add more methods below for each operation you'd like to implement.

  #  def create(order)
  #   sql =  sql = 'INSERT INTO order (customer_name, item_ordered, date_order) VALUES ($1, $2, $3);'
    
  #   sql_params = [order.customer_name, order.item_ordered, order.date_order]
  #   DatabaseConnection.exec_params(sql, sql_params)
  #  end
end 