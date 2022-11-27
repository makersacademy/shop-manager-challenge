require_relative 'item'
require_relative 'order'

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # # Executes the SQL query below:
    # sql = "SELECT id, name, unit_price, quantity FROM items;"
    # result_set = DatabaseConnection.exec_params(sql, [])

    # items = []

    # # loop through results and create an array of Item objects
    # # Return array of Item objects.
  end


  # Creating a new item record (takes an instance of Item)
  def create(item)
    # sql = "INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);"
    # params = [item.name, item.unit_price, item.quantity]
    # DatabaseConnection.exec_params(sql, params)
  end
end