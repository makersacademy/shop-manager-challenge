require_relative 'order.rb'
require './app'

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    result = DatabaseConnection.exec_params(sql,[])
    orders = []
    result.each do |record|
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date = record['date']
        order.item_id = record['item_id']

        orders.push(order)
    end
    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)
    record = result[0]
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']

    return order

  end

  def create(new_order)
  sql = 'INSERT INTO orders(id, customer_name, date, item_id) VALUES($1, $2, $3, $4)'
  sql_params = [new_order.id, new_order.customer_name, new_order.date, new_order.item_id]
  result = DatabaseConnection.exec_params(sql, sql_params)
  return nil
  end

end