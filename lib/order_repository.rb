require_relative "order.rb"

class OrderRepository

  def all
    sql = 'SELECT id, order_number, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.order_number = record['order_number']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']

      orders << order
    end
  end


  def create(order)
    sql = ‘INSERT INTO orders (order_number, customer_name, order_date) VALUES($1, $2, $3)’
    sql_params = [order.order_number, order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

end