require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    results = DatabaseConnection.exec_params(sql, [])
    # Returns an array of Order objects.
    orders = []

    results.each do |record|
      order = Order.new

      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id']

      orders << order
    end

    return orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;
    sql = 'SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;'

    results = DatabaseConnection.exec_params(sql, [id])

    # Returns a single Order object.
    record = results[0]
    
    order = Order.new

    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']

    return order
  end

  # creates a new record
  # one argument: an Order object
  def create(order)
    # Executes the SQL query
    # INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);
    sql = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.date, order.item_id]
    
    DatabaseConnection.exec_params(sql, params)
    # returns nothing
  end

  # def update(order)
  # end

  # def delete(order)
  # end
end
