require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date_placed FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date_placed = record['date_placed']
      all_orders << order
    end
    all_orders
  end

  def create(order,quantity,item_id)
    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES ($1, $2);'
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
    update_quantity(quantity,item_id)
  end

  def update_quantity(quantity,item_id)
    sql = 'UPDATE items SET quantity = $1 WHERE id = $2;'
    params = [current_quantity(item_id) - quantity, item_id]
    DatabaseConnection.exec_params(sql,params)
  end
  
  def current_quantity(item_id)
    sql = 'SELECT quantity FROM items WHERE id = $1'
    params = [item_id]
    result = DatabaseConnection.exec_params(sql,params)
    result[0]['quantity'].to_i
  end
end
