require_relative 'order'
require_relative 'database_connection'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date_placed, item_id
            FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []
    result_set.each do |record|
      orders << record_to_order(record)
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ($1, $2, $3);'
    params = [order.customer_name,
              order.date_placed,
              order.item_id]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private

  def record_to_order(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order.item_id = record['item_id'].to_i
    return order
  end
end