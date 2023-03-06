require_relative 'order'
class OrderRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id'].to_i
      orders << order
    end
    return orders
  end

  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set.first
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    order.item_id = record['item_id'].to_i
    return order
  end

  def create(order)
    sql =  'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3)'
    sql_params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end
