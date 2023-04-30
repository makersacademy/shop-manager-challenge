require_relative './order'

class OrderRepository
    def all
        sql = 'SELECT id, customer_name, date FROM orders'
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
        sql = 'SELECT id, customer_name, date FROM orders WHERE id = $1;'
        sql_params = [id]
        
        result = DatabaseConnection.exec_params(sql, sql_params)
        record = result[0]

        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date = record['date']

        return order

    end

    def create(order)
        sql = 'INSERT INTO orders
        (customer_name, date)
        VALUES($1, $2);'
        sql_params = [order.customer_name, order.date]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end


end