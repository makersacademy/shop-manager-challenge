require_relative './order'
class OrderRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, customer_name, date FROM orders;
      sql = 'SELECT id, customer_name, date FROM orders;'
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
      # Returns an array of Order objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id, customer_name, date FROM orders WHERE id = $1;
      sql = 'SELECT id, customer_name, date FROM orders WHERE id = $1;'
      sql_params = [id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      record = result_set[0]

      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']

      return order
      # Returns a single Order object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(order)
      # Executes the SQL query:
      # INSERT INTO orders (customer_name, date, stock_id) VALUES ($1, $2, $3);
      sql = 'INSERT INTO orders (customer_name, date, stock_id) VALUES ($1, $2, $3);'
      sql_params = [order.customer_name, order.date, order.stock_id]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
      # returns nothing
    end
  
    def update(order)
      # Executes the SQL query:
      # UPDATE orders SET customer_name = $1, date = $2, stock_id = $3 WHERE id = $4;
      sql = 'UPDATE orders SET customer_name = $1, date = $2, stock_id = $3 WHERE id = $4;'
      sql_params = [order.customer_name, order.date, order.stock_id, order.id]
      
      DatabaseConnection.exec_params(sql, sql_params)

      return nil
      # returns nothing
    end
  
    def delete(id)
      # Executes the SQL query:
      # DELETE FROM orders WHERE id = $1;
      sql = 'DELETE FROM orders WHERE id = $1;'
      sql_params = [id]

      DatabaseConnection.exec_params(sql, sql_params)
      return nil
      # returns nothing
  
    end
end