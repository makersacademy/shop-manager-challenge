require_relative './order'

class OrderRepository

    def all
        # Executes the SQL query:
        # SELECT id, customer_name, order_date, item_id FROM orders;
        sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
        params = []

        result_set = DatabaseConnection.exec_params(sql, params)

        orders = []
        
        result_set.each do |record|
            order = Order.new
            order.id = record['id'].to_i
            order.customer_name = record['customer_name']
            order.order_date = record['order_date']
            order.item_id = record['item_id'].to_i

            orders << order
        end

        return orders
        # Returns an array of Order objects.
    end

    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
        # Executes the SQL query:
        # SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;
        sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
        params = [id]

        result_set = DatabaseConnection.exec_params(sql, params)
        record = result_set[0]
            
        order = Order.new
        order.id = record['id'].to_i
        order.customer_name = record['customer_name']
        order.order_date = record['order_date']
        order.item_id = record['item_id'].to_i

        return order
       
    end

    # Inserts new Order record into database
    def create(order)
        # Executes the SQL query
        sql_1 = 'SELECT items.id AS item_id,
        items.name,
        orders.id AS order_id,
        items.unit_price,
        items.quantity,
        orders.customer_name,
        orders.order_date
        FROM items
            JOIN orders ON orders.item_id = items.id;'

        sql_2 = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);'
        
        sql_3 = 'UPDATE items SET quantity = quantity - 1 WHERE id = $1;'

        params = [order.customer_name, order.order_date, order.item_id]

        DatabaseConnection.exec_params(sql_1, [])
        DatabaseConnection.exec_params(sql_2, params)
        DatabaseConnection.exec_params(sql_3, [order.item_id])
    end

    # Deletes an existing Item record from database
    def delete(id)
        # Executes the SQL query
        # sql_1 = 'SELECT items.id AS item_id,
	    #    items.name,
	    #    orders.id AS order_id,
	    #    items.unit_price,
	    #    items.quantity,
	    #    orders.customer_name,
	    #    orders.order_date
	    #    FROM items
	    #    	JOIN orders ON orders.item_id = items.id;'

        # sql_2 = 'SELECT item_id AS item_value FROM orders WHERE id = $1'

        # sql_3 = 'UPDATE items SET quantity = quantity + 1 WHERE id = item_value'

        sql_4 = 'DELETE FROM orders WHERE id = $1;'
        
        # DatabaseConnection.exec_params(sql_1, [])
        # DatabaseConnection.exec_params(sql_2, [id])
        # DatabaseConnection.exec_params(sql_3, [])
        DatabaseConnection.exec_params(sql_4, [id])
        

        # Returns nothing
    end

    # Updates an existing Item record from database
    def change(order)
        # Executes the SQL query
        # SELECT items.id AS item_id,
	    #    items.name,
	    #    orders.id AS order_id,
	    #    items.unit_price,
	    #    items.quantity,
	    #    orders.customer_name,
	    #    orders.order_date
	    #    FROM items
	    #    	JOIN orders ON orders.item_id = items.id;
        # UPDATE i ...
    
        # Returns nothing
    end
end