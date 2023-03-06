require_relative './orders'
class OrdersRepository
    def all
        sql = 'SELECT * FROM orders;'
        
        result_set = DatabaseConnection.exec_params(sql, []) 
    
        orders =[]
        p orders
        result_set.each do |records|
          order = Orders.new
          order.id = records['id'].to_i
          order.customer_name = records['customer_name']
          order.order_date = records['order_date']
          order.item_id = records['item_id'].to_i
          orders << order
        end
        
        return orders
      end 

      def create(order)
        sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);'
        params = [order.customer_name, order.order_date, order.item_id]
        result_set = DatabaseConnection.exec_params(sql, params) 

      end
end