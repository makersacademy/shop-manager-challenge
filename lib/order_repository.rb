# frozen_string_literal: false

require_relative './order'
# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def list
    # sql = 'SELECT id, customer_name, order_date FROM orders;'
    sql = 'SELECT customer_name, order_date, items.item_name FROM orders
            JOIN items
            ON orders.id = items.order_id'
    result_set = DatabaseConnection.exec_params(sql, [])

    customer_date = Hash.new
    customer_items = Hash.new

    result_set.each do |record|
      name = record['customer_name']
      order_date = record['order_date']
      item = record['item_name']
      
      customer_date[name] = order_date
      if customer_items[name].nil?
        customer_items[name] = [item]
      else
        customer_items[name] = customer_items[name].push(item)
      end
    end

    orders = []
    # customer_date.each do |name, date|
    #   order = Order.new
    #   order.customer_name = name
    #   order.order_date = date
    #   order.items = customer_items[name]
    #   orders << order
    # end
    customer_date.each do |name, date|
      order = Hash.new
      order['customer_name'] = name
      order['order_date'] = date
      order['items'] = customer_items[name]
      orders << order
    end
    
    orders
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
