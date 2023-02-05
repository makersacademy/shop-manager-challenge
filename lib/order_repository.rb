require_relative 'order'

class OrderRepository
  def all 
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    sql_params = []

    result_orders = DatabaseConnection.exec_params(sql, sql_params)

    orders = []

    result_orders.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']
      
      orders << order
    end 

    return orders

  end 

  def find(id)
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1'
    sql_params = [id]

    result_order = DatabaseConnection.exec_params(sql, sql_params)

    result_order = result_order[0]

    order = Order.new
    order.id = result_order['id']
    order.customer_name = result_order['customer_name']
    order.order_date = result_order['order_date']
    order.item_id = result_order['item_id']

    return order 
  end 
  
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);'
    sql_params = [order.customer_name, order.order_date, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)

    
  end 
end