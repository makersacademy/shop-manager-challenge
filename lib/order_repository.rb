require_relative './database_connection'
require_relative './order'

class OrderRepository

  def all
    # Returns an array of Order objects
    orders = []

    select_all.each do |row|
      order = Order.new
      order.id = row['id'].to_i
      order.customer_name = row['customer_name']
      order.date = row['date']
      orders << order
    end

    return orders
  end

  def create(order)
    # Inserts an Order object into the DB
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2)'
    params = [order.customer_name, order.date]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def print_all
    # Returns an array of strings formatted to print with puts
  end

  private

  def select_all
    # Returns an array of hashes
    sql = 'SELECT * FROM orders'
    DatabaseConnection.exec_params(sql, [])
  end
end