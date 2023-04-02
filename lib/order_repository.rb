require_relative './order'

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer = record['customer']
      order.date = record['date']

      orders << order
    end

    orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, customer, date FROM orders WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    result.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer = record['customer']
      order.date = record['date']

      return order
    end
  end

  def create(order) # needs to assign items to the order using the join table
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
    params = [order.customer, order.date]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
end
