require_relative './item'
require_relative './database_connection'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record["id"].to_i
      item.name = record["name"]
      item.unit_price = record["unit_price"].gsub("$","£")
      item.quantity = record["quantity"].to_i
      items << item
    end
    return items
  end

  # Insert new item 
  # item is a new Item object
  def create(item)
    # Executes the SQL query:

    # INSERT INTO albums (name, unit_price, quantity) VALUES($1, $2, $3);
    # Doesn't need to return anything (only creates a record)
  end

end