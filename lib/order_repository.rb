require_relative 'order'

class OrderRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.

  def all_orders
    sql_statement = "SELECT orders.id, order_time, items.name AS item_name, customers.name AS customer_name FROM orders
    JOIN items ON items.id = orders.item_id
    JOIN customers on customers.id = orders.customer_id
    ORDER BY order_time DESC"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    results.each { |raw_data|
      order = Order.new
      order.id = raw_data['id'].to_i
      order.item_name = raw_data['item_name']
      order.customer_name = raw_data['customer_name']
      order.order_time = raw_data['order_time']
      output << order
    }
  return output
  end

  def last_order
    ## This method is only for testing purposes. It checks the last order in database
    ## to ensure order has been successfully added.
    sql_statement = "SELECT * FROM orders ORDER BY id DESC LIMIT 1"
    results = DatabaseConnection.exec_params(sql_statement, [])[0]
    order = Order.new
    order.id = results['id'].to_i
    order.item_id = results['item_id'].to_i
    order.customer_id = results['customer_id'].to_i
    order.order_time = results['order_time']
    return order
  end

  def add_order(input_parameters, date=DateTime.now.strftime("%Y-%m-%d"))
    sql_statement = "INSERT INTO orders(order_time, item_id, customer_id) VALUES ($1, $2, $3)"
    params = [date, input_parameters[:item_id], input_parameters[:customer_id]]
    results = DatabaseConnection.exec_params(sql_statement, params)
    return results
  end

  ### <--- FORMAT METHODS ---> ###
  ### These methods rework the information inside model objects into the required format strings.
  ### They will always return either a single string or an array of strings for the main application to print out.

  def order_list
    orders = all_orders
    output = []
    orders.each { |order|
      formatted_string = "Date: #{order.order_time}, Order ID: #{order.id}, Order Item: #{order.item_name}, Customer Name: #{order.customer_name}"
      output << formatted_string
    }
    return output
  end
end
