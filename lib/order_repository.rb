require_relative './order'
require_relative './database_connection'

class OrderRepository
  def all
    result_set = DatabaseConnection.exec_params('SELECT id, customer_name, date, item_id FROM orders;', [])

   orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id']

      orders << order
    end 
    orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders(customer_name, date, item_id) VALUES ($1, $2, $3);
    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id $1;
  end

end