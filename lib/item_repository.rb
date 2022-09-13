require '../lib/item'

class ItemRepository
  def all
    query = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(query, [])
    items = []
    result.each do |item|
      new_item = Item.new
      new_item.id = item['id']
      new_item.name = item['name']
      new_item.unit_price = item['unit_price']
      new_item.quantity = item['quantity']
      items << new_item
    end
    return items
  end

  def view_items
    self.all.each do |item|
      p("*Item ID: #{item.id}, #{item.name}, Unit Price: $#{item.unit_price}, quantity: #{item.quantity}*")
    end
  end

  def create(name, unit_price, quantity)
    query = 'INSERT INTO items (id, name, unit_price, quantity) VALUES($1, $2, $3, $4);'
    id = self.all.length + 1
    params = [id, name, unit_price, quantity]
    DatabaseConnection.exec_params(query, params)
  end

  def stock_level(item_id)
    query = 'SELECT quantity FROM items WHERE id = $1'
    params = [item_id]
    result = DatabaseConnection.exec_params(query, params)
    return result[0]['quantity'].to_i
  end

  def find_name(item_id)
    query = 'SELECT name FROM items WHERE id = $1'
    params = [item_id]
    result = DatabaseConnection.exec_params(query, params)
    return result[0]['name']
  end

  def amount
    self.all.length
  end
end

