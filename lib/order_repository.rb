require_relative './order'
# id, customer_name, date

class OrderRepository

  def list
    sql = 'SELECT id, customer_name, date FROM orders ORDER BY id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    formatted_entries = []
    result_set.each do |record|
      formatted_entries << "Order ID: #{record['id']} - Customer name: #{record['customer_name']} - Order date: #{record['date']}"
    end
    return formatted_entries.join("\n")
  end


  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (id, customer_name, date) VALUES ($1, $2, $3);'
    # here the new_order_id comes from a separate private method named new_order_id
    # feed the new_order_id in the sql_params
    sql_params = [new_order_id, order.customer_name, order.date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return puts "\nYour order has been successfully created.\n"
  end

  private
  def new_order_id
    # query for the last id in the table
    last_id_query = 'SELECT MAX(id) FROM orders;'
    last_id_result = DatabaseConnection.exec_params(last_id_query, [])

    new_id = nil
    # get the value of the last id
    last_id_result.each do |n|
      new_id =  n['max']
    end
    # new_id is being returned as a string so I convert it to an int
    # add one to the last id to create the new id
    new_id = Integer(new_id) + 1
    return new_id
  end

end
