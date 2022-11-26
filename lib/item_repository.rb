require_relative './item'
require_relative './database_connection'

class ItemRepository
  def all
    result_set = DatabaseConnection.exec_params(
    'SELECT id, name, unit_price, stock_count FROM items;', [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.stock_count = record['stock_count']

      items << item
    end 
    return items
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, stock_count FROM items WHERE id = $1;

    # Returns a single Student object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items(name, unit_price, stock_count) VALUES ($1, $2, $3);
    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id $1;
  end
end
