require_relative './database_connection'
require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, date, item_id FROM orders'
    repo = DatabaseConnection.exec_params(sql,[])
    orders = []
    repo.each do |record|
      orders << parse_record(record)
    end
    return orders
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;'
    params = [id]
    record = DatabaseConnection.exec_params(sql,params)[0]
    return parse_record(record)
    # Returns a single Item object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order)
    sql = 'INSERT INTO orders (customer_name,Date,item_id) VALUES($1,$2,$3);'
    params = [order.customer_name,order.date,order.item_id]
    DatabaseConnection.exec_params(sql,params)
    # Doesn't need to return as only creates
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    DatabaseConnection.exec_params(sql,[id])
    # Doesn't need to return as only deletes
  end

  def update(order)
    sql = 'UPDATE orders SET customer_name = $1, date = $2, item_id = $3 WHERE id = $4;'
    params = [order.customer_name,order.date,order.item_id,order.id]
    DatabaseConnection.exec_params(sql,params)
    # Doesn't need to return as only updates
  end

  private

  def parse_record(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']
    return order
  end
end
