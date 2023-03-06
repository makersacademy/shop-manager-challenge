require 'order_model'

class OrdersRepository
  def all
    sql = 'SELECT id, order_date, item_id, customer_id FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])
    orders_list = []
    order = Order.new
    loop_records(result, order, orders_list)
    return orders_list
  end
  
  def find(id)
    sql = 'SELECT id, order_date, item_id, customer_id FROM orders WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    order = Order.new
    order.id = record['id'].to_i
    order.order_date = record['order_date']
    order.item_id = record['item_id'].to_i
    order.customer_id = record['customer_id'].to_i
    return order
  end
  
  def create(order)
    sql = 'INSERT INTO orders (order_date, item_id, customer_id) VALUES ($1, $2, $3);'
    params = [order.order_date, order.item_id, order.customer_id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def update(order)
    sql = 'UPDATE orders SET order_date = $1, item_id = $2, customer_id = $3;'
    params = [order.order_date, order.item_id, order.customer_id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    return nil
  end

  private
  
  list = []
  def loop_records(result, order, list)
    result.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.order_date = record['order_date']
      order.item_id = record['item_id'].to_i
      order.customer_id = record['customer_id'].to_i
      list << order
    end
    return list
  end
end
