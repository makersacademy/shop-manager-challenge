require 'item'

class ItemRepository

  def all
    result = DatabaseConnection.exec_params('SELECT * FROM items;', [])
    all_items = []
    result.each do |row| 
      item = Item.new
      item.id = row['id']
      item.item_name = row['item_name']
      item.unit_price = row['unit_price']
      item.quantity = row['quantity']
      all_items << item
    end
    all_items
  end

  def create(item)
    sql = 'INSERT INTO items(item_name, unit_price, quantity) VALUES($1, $2, $3);'
    params = [item.item_name, item.unit_price, item.quantity]
    create = DatabaseConnection.exec_params(sql, params)
  end
end
