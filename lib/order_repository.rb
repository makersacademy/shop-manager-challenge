require_relative './order.rb'
require_relative './database_connection.rb'

class OrderRepository

    def all
        sql = 'SELECT * FROM orders;'
        result = DatabaseConnection.exec_params(sql, [])

        orders = []

        result.each do |record|
            orders << create_order_object(record)
        end

        return orders
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find_item_by_order_id(id)
      # Executes the SQL query:
      # SELECT id, name, cohort_name FROM orders WHERE id = $1;
  
      # Returns a single order object.
    end
  
  
    def create(order)
        sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
        params = [order.customer_name, order.order_date]
        DatabaseConnection.exec_params(sql, params)
        return nil
    #     order.items_to_buy each do |record| 

            
    #     end
    #   3 Add order number with matched items to the items_orders table
  
    #     sql = SELECT order.id FROM orders WHERE order.customer_name = $1
    #     params = [order.customer_name]
  
    #     params = [record, all.last]
    #     sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)
    end
  
    # def update(order)
    # end
  
    # def delete(order)
    # end
    private

    def create_order_object(record)
        order = Order.new
        order.id = record['id'].to_i
        order.customer_name = record['customer_name']
        order.order_date = record['order_date']
        return order
    end

  end