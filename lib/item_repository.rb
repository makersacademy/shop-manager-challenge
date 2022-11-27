require_relative 'item'

class ItemRepository

  def fill(unfilled)
    filled = Item.new
    filled.id = unfilled['id']
    filled.product = unfilled['product']
    filled.price = unfilled['price']
    filled.quantity = unfilled['quantity']
    filled
  end

  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items_array = []
    result_set.each do |item|
      items_array << fill(item)
    end
    items_array
  end

  def add(item)
    sql = 'INSERT INTO items (product, price, quantity) VALUES ($1, $2, $3);'
    params = [item.product, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

end