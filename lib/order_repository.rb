require_relative '../lib/order'
require_relative '../lib/item'

class OrderRepository
    def all
        items = []

        sql = 'SELECT * FROM orders;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
            new_order = Order.new
            new_order.id = record['id']
            new_order.customer_name= record['customer_name']
            new_order.order_date = record['order_date'

            orders << new_order
        end
        return orders
    end

    def create_order(name, items)
        items.each do |item_id|
            create_links(new_id,item_id)
            update_stock(item_id)
        DatabaseConnection.exec_params(sql, sql_params)
    end

    def new_id
        self.all.length + 1
    end
    
    def create_links(id, item_id)
        sql = 'INSERT INTO items_orders (item_id,order_id) VALUES($1, $2);'
        sql_params = [item_id, new_id]
        DatabaseConnection.exec_params(sql, sql_params)
    end

    def find_item(item_id)
        sql = 'SELECT name FROM items WHERE id = $1;'
        sql_params = [item_id]
        
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return result_set[0]['name']
    end

    def amount
        self.all.length
    end

    def view_orders
        self.all.each do |order|
            p("*#{order.id} - #{order.customer_name}, #(order.order_date}*")
        end
    end
end