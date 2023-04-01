require_relative 'order'

class OrderRepository
    def all
        orders = []
        sql = 'SELECT id, customer, date, order_id FROM orders;'
        result = DatabaseConnection.exec_params(sql,[])

        result.each do |sql_data|
            order = Order.new
            order.id = sql_data['id']
            order.customer = sql_data['customer']
            order.date = sql_data['date']
            order.order_id = sql_data['order_id']
            
            orders << order
        end
    return orders
    end

    def create(order)
        sql = 'INSERT INTO orders (customer, date, order_id) VALUES ($1, $2, $3);'
        params = [order.customer, order.date, order.order_id]
        DatabaseConnection.exec_params(sql, params)
    end
end