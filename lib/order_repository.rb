require_relative 'order'

class OrderRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.
  ### These methods always return objects (either single objects or in an array)
  ### Mapping of database information into these objects occur in these methods.

  def last_order
    ## This method is only for testing purposes. It checks the last order in database
    ## to ensure order has been successfully added.
    sql_statement = "SELECT * FROM orders ORDER BY id DESC LIMIT 1"
    results = DatabaseConnection.exec_params(sql_statement, [])
    raw_data = results[0]
    order = Order.new
    order.id = raw_data['id'].to_i
    order.item_id = raw_data['item_id'].to_i
    order.customer_id = raw_data['customer_id'].to_i
    order.order_time = raw_data['order_time']
    return order
  end

  def add_order(input_parameters, date=DateTime.now.strftime("%Y-%m-%d"))
    sql_statement = "INSERT INTO orders(order_time, item_id, customer_id) VALUES ($1, $2, $3)"
    params = [date, input_parameters[:item_id], input_parameters[:customer_id]]
    results = DatabaseConnection.exec_params(sql_statement, params)
  end
end
