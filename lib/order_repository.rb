require_relative './order'

class OrderRepository
    def all
        sql = 'SELECT id, customer_name, date FROM orders'
        result = DatabaseConnection.exec_params(sql, [])

        orders = []
        
        result.each do |record|
            
            # order = Order.new
            # order.id = record['id']
            # order.customer_name = record['customer_name']
            # order.date = record['date']

            orders << record_to_order(record)
        end

        return orders
    end

    def find(id)
        sql = 'SELECT id, customer_name, date FROM orders WHERE id = $1;'
        sql_params = [id]
        
        result = DatabaseConnection.exec_params(sql, sql_params)
        record = result[0]

        return record_to_order(record)

    end

    def create(order)
        sql = 'INSERT INTO orders
        (customer_name, date)
        VALUES($1, $2);'
        sql_params = [order.customer_name, order.date]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM orders
                    WHERE id = $1;'
        sql_params = [id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def find_with_items(id)
        sql = 'SELECT items.id, items.name, items.price
        FROM items
        JOIN items_orders ON items_orders.item_id = items.id
        JOIN orders ON items_orders.order_id = orders.id
        WHERE orders.id = $1;'
        sql_params = [id]
        result = DatabaseConnection.exec_params(sql, sql_params)
    end

    private
    def record_to_order(record)
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date = record['date']
        return order
    end


end
