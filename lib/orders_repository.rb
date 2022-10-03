require_relative 'album'

class OrdersRepository
  def all 
    orders = []
    sql = 'SELECT id, order, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
        orders = result_set.map do |record|
        order = Order.new(record['id'], record['order'], record['customer_name'], record['order_date'])
        end
    
     
      end
    return orders
  end
        def find(id)
            # The placeholder $1 is a "parameter" of the SQL query.
            # It needs to be matched to the corresponding element 
            # of the array given in second argument to exec_params.
            #
            # (If we needed more parameters, we would call them $2, $3...
            # and would need the same number of values in the params array).
            sql = 'SELECT id, order, customer_name, order_date FROM orders WHERE id = $1;'
        
            params = [id]
        
            result_set = DatabaseConnection.exec_params(sql, params)
            record = result_set[0]
              
              order = OrderRepository.new
              order.id = record['id']
              order.order = order['order']
              order.customer_name = record['customer_name']
              album.artist_id = record['order_date']

            return order
        end
    
end

