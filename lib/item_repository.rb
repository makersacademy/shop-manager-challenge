require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])

    items = []

    result.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      item.order_id = record['order_id']
      items << item
    end

    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity, order_id) VALUES ($1, $2, $3, $4);'
    params = [item.name, item.unit_price, item.quantity, item.order_id]
    DatabaseConnection.exec_params(sql, params)
  end
end