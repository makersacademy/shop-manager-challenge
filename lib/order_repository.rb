require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders'
    result = DatabaseConnection.exec_params(sql, [])
    orders_array = []
    result.each do |row|
      order = Order.new
      order.id, order.customer_name, order.order_date, order.item_id =
        row['id'], row['customer_name'], row['order_date'], row['item_id']
      orders_array << order
    end
    return orders_array
  end
  
  def find(id)
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1'
    param = [id]
    result = DatabaseConnection.exec_params(sql, [id])
    row = result.first
    order = Order.new
    order.id, order.customer_name, order.order_date, order.item_id =
      row['id'], row['customer_name'], row['order_date'], row['item_id']
    return order
  end
  
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3)'
    params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1'
    param = [id]
    DatabaseConnection.exec_params(sql, param)

    return nil
  end
  
  def update(order)
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4'
    params = [order.customer_name, order.order_date, order.item_id, order.id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end