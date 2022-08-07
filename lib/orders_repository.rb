require_relative 'order'

class OrdersRepository

  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    output = []
    result_set.each{|object|
      order = Order.new
      order.id = object['id']
      order.customer_name = object['customer_name']
      order.order_date = object['order_date']
      order.item_id = object['item_id']
      output << order
      }
     return output
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
     sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    order = Order.new
    result_set.each{|object|
      order.id = object['id']
      order.customer_name = object['customer_name']
      order.order_date = object['order_date']
      order.item_id = object['item_id']
      }
      return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);'
    params = [order.customer_name, order.order_date, order.item_id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

 def update(order)
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4;'
    params = [order.customer_name, order.order_date, order.item_id, order.id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

 def delete(order)
    sql = 'DELETE FROM orders WHERE id = $1;'
    params = [order.id]
    DatabaseConnection.exec_params(sql, params)
 end
end