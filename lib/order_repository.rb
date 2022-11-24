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
end
