require_relative './order'

class OrderRepository

  # Selecting all orders
  # No arguments
  def all
    orders = []
    # defining sql query string
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    # executes sql query and passes sql string and an empty array as an argument
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |inst|
      # for each instance it creates a new instance and assigns corresponding atributes
      order = Order.new

      order.id = inst['id']
      order.customer_name = inst['customer_name']
      order.order_date = inst['order_date']

      orders << order
    end

    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
  
    if result.ntuples.zero?
      return nil
    else
      order = Order.new
  
      order.id = result[0]['id']
      order.customer_name = result[0]['customer_name']
      order.order_date = result[0]['order_date']
  
      return order
    end
  end

  def create(order)

    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
    params = [order.customer_name, order.order_date]

    DatabaseConnection.exec_params(sql, params)

    return nil

  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(order)
    # Executes the SQL;
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2 WHERE id = $3;'
    params = [order.customer_name, order.order_date, order.id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
