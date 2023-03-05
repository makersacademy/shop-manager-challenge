require_relative "./item"
require_relative "./database_connection"

class ItemRepository
  
  def all
    result_set = DatabaseConnection.exec_params("SELECT * FROM items;", [])
    items_list = []
    result_set.each do |record|
      item = Item.new
      item.id, item.name = record['id'], record['name']
      item.unit_price, item.quantity = record['unit_price'], record['quantity']
      items_list << item
    end
    return items_list
  end

  def create(new_item) # new_item is an instance of Item class
    query = "INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)"
    sql_params = [new_item.name, new_item.unit_price, new_item.quantity]
    DatabaseConnection.exec_params(query, sql_params)
    return nil
  end
end
