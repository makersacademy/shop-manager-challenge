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

  def find(id)
    sql = "SELECT * FROM items WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    item = Item.new
    item.id = result.first['id']
    item.name = result.first['name']
    item.price = result.first['price'].to_f
    item.quantity = result.first['quantity'].to_i
    result.each do |row|
      order = Order.new
      order.id = row['order_id']
      order.customer_name = row['customer_name']
      order.order_date = row['order_date']
      item.orders << order
    end
    item
  end

  def find_with_order(order)
    sql = "SELECT *
           FROM items
           JOIN items_orders ON items.id = items_orders.item_id
           JOIN orders ON items_orders.order_id = orders.id
           WHERE orders.order_date = $1;"
    params = [order]
    item_list = []
    result = DatabaseConnection.exec_params(sql, params)
    result.each do |row|
      item = Item.new
      item.id = row['id']
      item.name = row['name']
      item.price = row['price'].to_f
      item.quantity = row['quantity'].to_i
      item_list << item
    end
    item_list
  end

end