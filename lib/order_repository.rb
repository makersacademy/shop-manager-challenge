
class OrderRepository
  # Selecting all records
    # No arguments
    def all
        sql = 'SELECT id, item, price, quantity FROM stocks;'
        result_set = DatabaseConnection.exec_params(sql, [])

        orders = []
  
        result_set.each do |record|
        order = order.new
  
        order.id = record['id']
        order.customer = record['customer']
        order.order_date = record['order_date']
        order.stock_id = record['stock_id']
  
        orders << order
      end
      return orders
    end