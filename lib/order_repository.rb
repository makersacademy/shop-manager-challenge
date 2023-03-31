require_relative './database_connection'
require_relative './order'

class OrderRepository

  def select_all
    # Returns an array of hashes
    sql = 'SELECT * FROM orders'
    DatabaseConnection.exec_params(sql, [])
  end

  def all
    # Returns an array of Order objects
    orders = []

    select_all.each do |row|
      order = Order.new
      order.customer_name = row['customer_name']
      order.date = row['date']
      orders << order
    end

    return orders
  end

  def create(item)
    # Inserts an Order object into the DB
    # Returns nil
  end

  def print_all
    # Returns an array of strings formatted to print with puts
  end
end