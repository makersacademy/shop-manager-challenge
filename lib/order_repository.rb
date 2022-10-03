require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/order.rb'
require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item.rb'

class OrderRepository
  def all
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
  end

  def find(id)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    record = result[0]

    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
    sql_params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end
end