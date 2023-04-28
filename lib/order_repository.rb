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