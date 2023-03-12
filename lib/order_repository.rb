require_relative 'order'

class OrderRepository
  def all
    orders = []

    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id'].to_i
      orders << order
    end
    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1';
    result_set = DatabaseConnection.exec_params(sql, [id])
    
    order = Order.new
    order.id = result_set[0]['id'].to_i
    order.customer_name = result_set[0]['customer_name']
    order.date = result_set[0]['date']
    order.item_id = result_set[0]['item_id'].to_i

    return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    result_set = DatabaseConnection.exec_params(sql, [order.customer_name, order.date, order.item_id])

    return order
  end
end
