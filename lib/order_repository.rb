# frozen_string_literal: false

require 'order'
# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def list
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      orders << order
    end

    orders
    # Returns an array of Order objects.
    # TODO use SELECT to join corresponding items
    # SELECT *
    #   FROM items
    # JOIN orders
    # ON orders.id = items.order_id;
  end

  # Create a new order
  # One argument: Order object
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES($1,$2) RETURNING id;'
    sql_params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, sql_params)

    # Returns order id
  end
end