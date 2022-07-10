require_relative './order'

class OrdersRepository
    def all
        sql = 'SELECT * FROM orders;'
        result_set = DatabaseConnection.exec_params(sql, [])
        orders = []
        result_set.each do |record|
            order = Order.new
            order.id = record['id']
            order.customer_name = record['customer_name']
            order.date = record['date']
            orders << order
        end
        return orders
    end

    def find(id)
        sql = 'SELECT customer_name, date FROM orders WHERE id = $1;'
        param = [id]
        result_set = DatabaseConnection.exec_params(sql, param)
        record = result_set[0]
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date = record['date']
        return order
    end

    def create(new_order)
        sql = 'INSERT INTO orders (id, customer_name, date) VALUES(
            $1, $2, $3);'
        param = [new_order.id, new_order.customer_name, new_order.date]
        result_set = DatabaseConnection.exec_params(sql, param)
        return nil
    end

    def delete(id_to_delete)
        sql = 'DELETE FROM orders WHERE id = $1;'
        param = [id_to_delete]
        result_set = DatabaseConnection.exec_params(sql, param)
        return nil
    end
end