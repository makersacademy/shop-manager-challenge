require_relative './database_connection'
require_relative './order'

class OrderRepository

  # def all
  #   # Returns an array of Order objects
  #   orders = []

  #   select_all_with_items.each do |row|
  #     order = Order.new
  #     order.id = row['order_id'].to_i
  #     order.customer_name = row['customer_name']
  #     order.date = row['date']
  #     # Unless the order object already has this item in...
  #     item = Item.new
  #     item.name = row['name'] # if item.name.empty?
  #     item.unit_price = row['unit_price'] # if item.unit_price.empty?
  #     order.items << item
  #     orders << order
  #   end
  #   puts orders
  #   return orders
  # end

  def all
    # Returns an array of Order objects

    sql = 'SELECT * FROM orders'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |row|
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

  def print_all_with_items
    # Returns an array of strings formatted to print with puts
    sql = 'SELECT orders.id AS "order_id", customer_name, date, items.name, items.unit_price FROM orders
                JOIN items_orders ON orders.id = order_id
                JOIN items ON item_id = items.id;'
    result_set = DatabaseConnection.exec_params(sql, [])

  end

  private

  # def select_all_with_items
  #   # Returns an array of hashes
  #   sql = 'SELECT orders.id AS "order_id", customer_name, date, items.name, items.unit_price FROM orders
  #             JOIN items_orders ON orders.id = order_id
  #             JOIN items ON item_id = items.id;'
  #   DatabaseConnection.exec_params(sql, [])
  # end
end