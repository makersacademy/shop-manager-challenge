require 'order'

class OrderRepository

    def all 
        orders = []
        sql = 'SELECT * FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])
        result.each do |item|
            order = Order.new 
            order.id = item['id']
            order.cname = item['cname']
            order.time = item['time']
            order.date = item['date']
            order.stock_id = item['stock_id']
            orders << order
        end 
        return orders
    end 

    def find(id)
        sql = 'SELECT * FROM orders WHERE id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        record = result[0]

        order = Order.new
        order.id = record['id']
        order.cname = record['cname']
        order.time = record['time']
        order.date = record['date']
        order.stock_id = record['stock_id']
        
        return order
    end 

    def create(order) 
        sql = 'INSERT INTO orders (id, cname, time, date) VALUES ($1, $2, $3, $4);'
        params = [order.id, order.cname, order.time, order.date]

        DatabaseConnection.exec_params(sql, params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM orders WHERE id = $1;'
        DatabaseConnection.exec_params(sql, [id])

        return nil
    end

    def update(id, col, val) 
        
        if col == 'cname'
            sql = 'UPDATE orders SET cname = $2 WHERE id = $1;'
        elsif col == 'time'
            sql = 'UPDATE orders SET time = $2 WHERE id = $1;'
        elsif col == 'date'
            sql = 'UPDATE orders SET date = $2 WHERE id = $1;'
        end 
        params = [id, val]
        DatabaseConnection.exec_params(sql, params)

        return nil
    end 
end 