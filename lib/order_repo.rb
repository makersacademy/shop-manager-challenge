require_relative 'order'
require_relative 'database_connection'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(sql ,[])
    result.map { |record| make_order(record) }
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date_placed)
      VALUES ($1, $2);'
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  def update(id, order)
    sql = 'UPDATE orders
      SET (customer_name, date_placed) = ($1, $2) 
      WHERE id = $3;'
    params = [order.customer_name, order.date_placed, id]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  private

  def make_order(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order
  end
end