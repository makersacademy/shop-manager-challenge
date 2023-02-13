require_relative "order"
require "pg"

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      orders << order
    end
    
    return orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    
    return order
  end

  # Add more methods below for each operation you'd like to implement.
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.order_date]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  
  end
  
  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(order)
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2 WHERE id = $3;'
    sql_params = [order.customer_name, order.order_date, order.id]
    
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end