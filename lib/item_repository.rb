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

  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)"
    sql_params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)
  end

end