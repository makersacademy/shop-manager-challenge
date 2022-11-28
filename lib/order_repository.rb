require_relative './order'

class OrderRepository

    def all 
       sql = 'SELECT * FROM orders;'
       result = DatabaseConnection.exec_params(sql, [])

       orders = []

       result.each do |record|
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date = record['date']

        orders << order
       end

       return orders

    end

    def find(id)

        sql = 'SELECT * FROM orders WHERE id = $1;'

        params = [id]
        
        result = DatabaseConnection.exec_params(sql, params)

        order = Order.new
        order.id = result[0]['id']
        order.customer_name = result[0]['customer_name']
        order.date = result[0]['date']

        return order
    end

    def create(order)
        sql = 'INSERT INTO orders
        (customer_name, date)
        VALUES ($1, $2)'

        params = [order.customer_name, order.date]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM orders WHERE id = $1'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)    
        return nil
    end
end