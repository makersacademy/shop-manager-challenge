require_relative 'order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    orders = []
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'

    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      orders << record_to_order_object(record)
    end
    # Returns an array of Order objects.
    return orders
  end

  # Create a new record
  # given a new Order Object
  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.order_date, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)
    # Does not return a value
  end

  private

  def record_to_order_object(record)
    order = Order.new

    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    order.item_id = record['item_id'].to_i

    return order
  end

end
