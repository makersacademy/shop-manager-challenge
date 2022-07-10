require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
   #SELECT id, customer_name, date_ordered, item_id FROM orders;
   sql = 'SELECT * FROM orders;'
   result_set = DatabaseConnection.exec_params(sql, [])
   orders = []

   result_set.each do |record|
        order = Order.new
        order.id = record['id'].to_i
        order.customer_name = record['customer_name']
        order.date_ordered = record['date_ordered']
        order.item_id = record['item_id'].to_i
        orders << order
   end
   return orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, customer_name, date_ordered, item_id FROM orders WHERE id = $1;

  #   # Returns a single Order object.
  # end

  # # Add more methods below for each operation you'd like to implement.

  def create(order)
   # Executes the SQL query:
    # INSERT INTO orders  (id, customer_name, date_ordered, item_id) VALUES ($1, $2, $3, $4);
    sql = 'INSERT INTO orders (customer_name, date_ordered, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.date_ordered, order.item_id]
    DatabaseConnection.exec_params(sql, params)
   
  end
end
