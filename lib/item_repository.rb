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

  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);"
    params = [item.name, item.price, item.quantity]
    result = DatabaseConnection.exec_params(sql, params)
  end

end