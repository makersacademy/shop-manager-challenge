require_relative 'item'

class ItemRepository

  ### <--- DB METHODS --- > ###
  ### This section includes methods which interact directly with database.
  ### These methods always return objects (either single objects or in an array)
  ### Mapping of database information into these objects occur in these methods.

  def all
    sql_statement = "SELECT * FROM items"
    output = []
    results = DatabaseConnection.exec_params(sql_statement, [])
    results.each { |raw_data|
      item = Item.new
      item.id = raw_data['id']
      item.name = raw_data['name']
      item.unit_price = raw_data['unit_price'].to_i
      item.quantity = raw_data['quantity']
      output << item
    }
  return output
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