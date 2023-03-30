require_relative 'customer'

class CustomerRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.
  ### These methods always return objects (either single objects or in an array)
  ### Mapping of database information into these objects occur in these methods.

  def all
    sql_statement = "SELECT * FROM customers"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    results.each { |raw_data|
      customer = Customer.new
      customer.id = raw_data['id'].to_i
      customer.name = raw_data['name']
      output << customer
    }
  return output
  end

  def all_orders
    sql_statement = "SELECT order_time, items.name AS item_name, customers.name AS customer_name FROM orders
    JOIN items ON items.id = orders.item_id
    JOIN customers on customers.id = orders.customer_id
    ORDER BY order_time DESC"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    return results
  end

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

  ### <--- FORMAT METHODS ---> ###
  ### These methods rework the information inside model objects into the required format strings.
  ### They will always return either a single string or an array of strings for the main application to print out.
  
  def customer_list
    customers = all
    output = []
    customers.each { |customer|
      formatted_string = "Customer ID: #{customer.id}, Name: #{customer.name}"
      output << formatted_string
    }
    return output
  end

  def order_list
    orders = all_orders
    output = []
    orders.each { |order|
      formatted_string = "Date: #{order["order_time"]}, Order Item: #{order["item_name"]}, Customer Name: #{order["customer_name"]}"
      output << formatted_string
    }
    return output
  end

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