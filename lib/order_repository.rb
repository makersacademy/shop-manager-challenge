require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
      order = Order.new(
        record['customer_name'],
        record['date'],
        record['item_id'].to_i,
      )
      order.id = record['id'].to_i
      orders << order
      end
    orders
  end

  def create(order)
  sql = 'INSERT INTO orders (customer_name, date, item_id)
  VALUES($1, $2, $3);'
 
  params = [order.customer_name, order.date, order.item_id]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end