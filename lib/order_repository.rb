require_relative './order'

class OrderRepository

  # Selecting all orders
  # No arguments
  def all
    orders = []
    #defining sql query string
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    #executes sql query and passes sql string and an empty array as an argument
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |inst|
      #for each instance it creates a new instance and assigns corresponding atributes
      order = Order.new

      order.id = inst['id']
      order.customer_name = inst['customer_name']
      order.order_date = inst['order_date']

      orders << order
    end

    return orders
  end

  def find(id)
    orders = []
    sql = 'SELECT customer_name, order_date FROM orders WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    result.each do |inst|
      order = Order.new

      order.id = inst['id']
      order.customer_name = inst['customer_name']
      order.order_date = inst['order_date']

      return order
    end
  end

  def create(order)

    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
    params = [order.customer_name, order.order_date]

    DatabaseConnection.exec_params(sql, params)

    return nil

  end

end