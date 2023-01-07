require_relative '../database_connection'
require 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    results_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    results_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id'].to_i
      orders << order
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end

end