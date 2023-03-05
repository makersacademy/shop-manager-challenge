require_relative 'order'
class OrderRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      result_set = DatabaseConnection.exec_params('SELECT id, customer_name,the_date FROM orders;',[])
      orders = []
      result_set.each do |a_order|
        order = Order.new
        order.id = a_order['id']
        order.customer_name= a_order['customer_name']
        order.the_date= a_order['the_date']
        orders << order
      end
      return orders
      # Returns an array of Item objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
     
  
      # Returns a single Item object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    # def create(item)
    # end
  
    # def update(item)
    # end
  
    # def delete(item)
    # end
  end