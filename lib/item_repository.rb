require_relative './item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items'
    records = DatabaseConnection.exec_params(sql, [])
    items = []

    records.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end

    return items
  end


end