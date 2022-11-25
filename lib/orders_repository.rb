require_relative 'orders'

class OrdersRepository
  
  def all
    sql = 'SELECT id, name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    
    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.name = record['name']
      order.date = record['date']
      order.item_id = record['item_id']
      orders << order
    end
    orders
  end

  def find(id)
    sql = 'SELECT id, name, date, item_id FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    order = Order.new
    order.id = record['id']
    order.name = record['name']
    order.date = record['date']
    order.item_id = record['item_id']
    order
  end

  def create(order)
    sql = 'INSERT INTO orders (name, date, item_id) VALUES ($1, $2, $3);'
    params = [order.name, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end
end 