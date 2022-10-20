require_relative './order'

class OrderRepository
  
  def all
    sql_query = 'SELECT * FROM orders;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    
    all_orders = result_set.map { |record| record_to_order(record) }
      
    return all_orders
  end
  
  def find(id)
    sql_query = 'SELECT * FROM orders WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    result_set = result_set.map { |record| record_to_order(record) }
    
    return false if result_set.empty?
     
    find_result = result_set.first
    return find_result
  end
  
  def create(order)
    sql_query = 'INSERT INTO orders (order_date, customer_name) VALUES ($1, $2) RETURNING id;'
    sql_params = [order.order_date, order.customer_name]
    result = DatabaseConnection.exec_params(sql_query, sql_params)
    new_order_id = result[0]['id'].to_i
    return new_order_id
  end
  
  def find_by_item(item_id)
    sql_query = "SELECT orders.id, orders.order_date, orders.customer_name FROM orders \
    JOIN items_orders ON items_orders.order_id = orders.id \
    JOIN items ON items_orders.item_id = items.id \
    WHERE items.id = $1;"
    sql_params = [item_id]
    
    result_set = DatabaseConnection.exec_params(sql_query, sql_params)
    
    orders = result_set.map { |record| record_to_order(record) }
    
    return false if orders.empty?
    return orders
  end
  
  def assign_order_to_item(order_id, item_id)
    sql_query = "INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)"
    sql_params = [item_id, order_id]
    DatabaseConnection.exec_params(sql_query, sql_params)
    return nil
  end
  
  private
  
  def record_to_order(record)
    order = Order.new
    order.id = record['id'].to_i
    order.order_date = record['order_date']
    order.customer_name = record['customer_name']
    return order
  end
  
end
