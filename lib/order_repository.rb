require_relative './order'

class OrderRepository

  def all
    orders = []
    sql = "SELECT id, customer_name, order_date, item_id FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

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
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    order.item_id = record['item_id'].to_i
      
    return order

  end
  def create(order)
    orders = []
    sql = 'INSERT INTO orders(customer_name, order_date, item_id) VALUES($1, $2, $3) RETURNING *; '
    sql_params = [order.customer_name, order.order_date, order.item_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
      
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

end
