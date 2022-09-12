require_relative 'item'
require_relative 'order'

class OrderRepository
    def all
        orders = []
        sql = 'SELECT id, customer, date FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])

        result.each do |ord|
            order = Order.new
            order.id = ord['id']
            order.customer = ord['customer']
            order.date = ord['date']
            orders << order
        end
        orders
    end

    def create(order)
        sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
        params = [order.customer, order.date]

        DatabaseConnection.exec_params(sql, params)
    end
end