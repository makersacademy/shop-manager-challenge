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
  def create(item) # item is an instance of the Item class
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);  
    returns nil
  end


  private

  def set_attributes(item, record)
    item.id = record["id"].to_i
    item.name = record["name"]
    item.price = record["price"].to_i
    item.quantity = record["quantity"].to_i
  end
end