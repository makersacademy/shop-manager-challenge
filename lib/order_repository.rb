require "order"

class OrderRepository
  def all
    sql_query = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql_query,[])
    orders = []
    result_set.each do |ord|
      order = Order.new
      order.id = ord['id'].to_i
      order.customer_name = ord['customer_name']
      order.order_date = ord['order_date']
      order.item_id = ord['item_id']
      orders << order
    end

    return orders
  end

  def find(id)
    sql_query = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql_query,params)[0]
    
    order = Order.new
    order.id = result_set['id'].to_i
    order.customer_name = result_set['customer_name']
    order.order_date = result_set['order_date']
    order.item_id = result_set['item_id']

    return order
  end

  def create(order)
    sql_query = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql_query, params)
  end

  def delete(id)
    sql_query = 'DELETE FROM orders WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql_query,params)
  end

  def update(order)
    sql_query = 'UPDATE orders SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4;'
    params = [order.customer_name, order.order_date, order.item_id, order.id]
    DatabaseConnection.exec_params(sql_query,params)
  end
end
