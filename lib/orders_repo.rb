require_relative './order'
require_relative './database_connection'
require 'pg'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, customer_name, date_of_order FROM orders;'
    DatabaseConnection.connect('database_orders_test')
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date_of_order = record['date_of_order']

      orders << order
    end 
    # Returns an array of Album objects.
     return orders
  end

    # Select a single record
    # Given the id in argument(a number)

  def find(id) 
    sql = 'SELECT id, customer_name, date_of_order FROM orders WHERE id = $1'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_of_order = record['date_of_order']
    
    return order
  end 

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date_of_order) VALUES ($1, $2) RETURNING id, customer_name, date_of_order'
    sql_params = [order[:customer_name], order[:date_of_order]]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    new_order = Order.new
    new_order.id = record['id']
    new_order.customer_name = record['customer_name']
    new_order.date_of_order = record['date_of_order']

    return new_order
  end
end
