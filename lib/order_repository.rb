require 'order'

class OrderRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, customer_name, date FROM orders;'
      result_set = DatabaseConnection.exec_params(sql,[])

      orders = []

      result_set.each do |result|
        order = Order.new
        order.id = result['id']
        order.customer_name = result['customer_name']
        order.date = result['date']

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
  
      # Returns a single Order object.
    end
  
    def create(order)
      sql = 'INSERT INTO orders (customer_name, date) VALUES ($1,$2);'
      sql_params = [order.customer_name, order.date]
      DatabaseConnection.exec_params(sql,sql_params)

      return nil
  
      #Doesn't return anything
    end
  
  end