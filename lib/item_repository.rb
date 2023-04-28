require 'item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    items = []

    sql = 'SELECT * FROM items';
    repo = DatabaseConnection.exec_params(sql, [])
    
    repo.each do |record|
      item = Item.new
      set_attributes(item, record)
      items << item
    end

    items
  end

# Creating a new item
  def create(new_item) # item is an instance of the Item class
   sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'  
   params = [new_item.name, new_item.price, new_item.quantity]
   DatabaseConnection.exec_params(sql, params)
   return nil
  end


  private

  def set_attributes(item, record)
    item.id = record["id"].to_i
    item.name = record["name"]
    item.price = record["price"].to_i
    item.quantity = record["quantity"].to_i
  end
end