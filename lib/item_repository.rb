require 'item'

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    all_items = []
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |entry|
      all_items << item_inflate(entry)
    end
    return all_items
  end

  # def find(id)
  #   single_item = []
  #   sql = 'SELECT * FROM items WHERE id = $1;'
  #   sql_params = [id]
  #   result_set = DatabaseConnection.exec_params(sql, sql_params)
  #   entry = result_set[0]
  #     single_item << item_inflate(entry)
  #   return single_item
  # end
   # Extra method not required by challenge

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.item_name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  private 

  def item_inflate(entry)
    item = Item.new
    item.id = entry["id"].to_i
    item.item_name = entry['item_name']
    item.unit_price = entry['unit_price'].to_i
    item.quantity = entry['quantity'].to_i
    return item
  end

end
