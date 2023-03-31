require_relative 'customer'

class CustomerRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.
  ### These methods always return objects (either single objects or in an array)
  ### Mapping of database information into these objects occur in these methods.

  def orders_of_customer(customer_name)
    sql_statement = "SELECT orders.id, order_time, items.name FROM orders
    JOIN items ON items.id = orders.item_id
    JOIN customers on customers.id = orders.customer_id
    WHERE customers.name = $1
    ORDER BY order_time DESC"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [customer_name])
    return results
  end

  def retrieve_customer_by_name(customer_name)
    ## This method checks the query result. It returns the id
    ## if customer records exist, returns false if no records exist with that name
    sql_statement = "SELECT * FROM customers WHERE name = $1"
    results = DatabaseConnection.exec_params(sql_statement, [customer_name])
    results.ntuples.zero? ? false : results[0]['id'].to_i
  end

  def add_customer(customer_name)
    sql_statement = "INSERT INTO customers(name) VALUES($1)"
    results = DatabaseConnection.exec_params(sql_statement, [customer_name])
  end

  ### <--- FORMAT METHODS ---> ###
  ### These methods rework the information inside model objects into the required format strings.
  ### They will always return either a single string or an array of strings for the main application to print out.

  def list_of_items_ordered_by_customer(customer_name)
    orders = orders_of_customer(customer_name)
    output = []
    orders.each { |order| 
      formatted_string = "On #{order["order_time"]}, ordered #{order["name"]}"
      output << formatted_string
    }
    return output
  end
end