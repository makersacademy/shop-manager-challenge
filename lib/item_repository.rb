class ItemRepository
  def all
    sql = "SELECT * FROM items;"
    item_list = []
    items = DatabaseConnection.exec_params(sql, [])
    items.each do |row|
      item = Item.new
      item.id = row['id']
      item.name = row['name']
      item.price = row['price']
      item.quantity = row['quantity']
      item_list << item
    end
    item_list
  end

end