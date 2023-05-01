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
end