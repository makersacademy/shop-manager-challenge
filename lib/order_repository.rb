require_relative './order'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    orders = []
  
    result_set.each do |record|
      order = Order.new(
        id: record['id'].to_i,
        customer_name: record['customer_name'],
        item_id: record['item_id'].to_i,
        date: record['date']
      )
  
      orders << order
    end
  
    return orders
  end

  def find(id)
    sql = 'SELECT * FROM orders WHERE id = $1'
    result_set = DatabaseConnection.exec_params(sql, [id])

    return nil if result_set.ntuples.zero?

    record = result_set.first
    Order.new(
      id: record['id'].to_i,
      customer_name: record['customer_name'],
      item_id: record['item_id'].to_i,
      date: record['date']
    )
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, item_id, date) VALUES ($1, $2, $3) RETURNING id'
    result = DatabaseConnection.exec_params(sql, [order.customer_name, order.item_id, order.date])
    order.id = result[0]['id'].to_i
  end

  def update(id, order)
    sql = 'UPDATE orders SET customer_name = $1, item_id = $2, date = $3 WHERE id = $4'
    DatabaseConnection.exec_params(sql, [order.customer_name, order.item_id, order.date, id])
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1'
    DatabaseConnection.exec_params(sql, [id])
  end
end
