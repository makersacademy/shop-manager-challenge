require_relative 'item'

class ItemRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.

  def all
    sql_statement = "SELECT * FROM items"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    results.each { |raw_data|
      item = Item.new
      item.id = raw_data['id'].to_i
      item.name = raw_data['name']
      item.unit_price = raw_data['unit_price'].to_i
      item.quantity = raw_data['quantity'].to_i
      output << item
    }
  return output
  end

  def add_item(input_parameters)
    sql_statement = "INSERT INTO items(name, unit_price, quantity) VALUES($1, $2, $3)"
    params = [input_parameters[:name], input_parameters[:unit_price], input_parameters[:quantity]]
    results = DatabaseConnection.exec_params(sql_statement, params)
  end

  def retrieve_item_id_by_name(item_name)
    ## This method checks the query result. It returns the id
    ## if item exists in store, otherwise returns false
    sql_statement = "SELECT * FROM items WHERE name = $1 AND quantity > 0"
    results = DatabaseConnection.exec_params(sql_statement, [item_name])
    results.ntuples.zero? ? false : results[0]['id'].to_i
  end

  ### <--- FORMAT METHODS ---> ###
  ### These methods rework the information inside model objects into the required format strings.
  ### They will always return either a single string or an array of strings for the main application to print out.
  
  def price_list
    items = all
    output = []
    items.each { |item|
      formatted_string = "Item: #{item.id}, Name: #{item.name}, Price: #{item.unit_price}"
      output << formatted_string
    }
    return output
  end

  def inventory_stock_list
    items = all
    output = []
    items.each { |item|
      formatted_string = "Item: #{item.id}, Name: #{item.name}, Quantity: #{item.quantity}"
      output << formatted_string
    }
    return output
  end
end