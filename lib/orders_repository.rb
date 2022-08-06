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

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end