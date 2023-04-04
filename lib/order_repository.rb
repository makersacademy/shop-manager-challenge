require_relative './database_connection'
require_relative './order'

class OrderRepository

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
    orders = []
    order_ids = []
    result_set.sort_by { |row| row["order_id"] }.each do |hash|
      if !order_ids.include? hash["order_id"].to_i
        order_ids << hash["order_id"].to_i
        order = Order.new
        order.id = hash["order_id"].to_i
        order.customer_name = hash["customer_name"]
        order.date = hash["date"]
        orders << order
      end
    end

    result_set.each do |hash|
      orders.each do |order|
        if order.id == hash["order_id"].to_i
          item = Item.new
          item.name = hash["name"]
          item.unit_price = hash["unit_price"]#.to_f.round(2)
          order.items << item
        end
      end
    end
    output = []
    orders.map do |order|
      output << " Order ##{order.id} - #{order.customer_name} - #{order.date}\n   Items:"
      order.items.each do |item|
        output << "     #{item.name}, £#{item.unit_price}"
      end
    end
    return output

  end

  #private

end