require_relative 'item'
require_relative 'order'

class ItemRepository
  # Select and return all items
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, unit_price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record["id"]
      item.name = record["name"]
      item.unit_price = record["unit_price"]
      item.quantity = record["quantity"]

      items << item
    end

    return items  
  end


  # Creating a new item record (takes an instance of Item)
  def create(item)
    raise "Only items can be added" if (!item.is_a? Item)
    
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);"
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end