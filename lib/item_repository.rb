require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT * FROM items ORDER BY id;'
    results = DatabaseConnection.exec_params(sql, [])
    items = []
    results.each do |record|
      items << record_to_object(record)
    end
    items
  end
  
  def create(item)
    sql = "INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);"
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def find(id)
    sql = "SELECT * FROM items WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    record_to_object(record)
  end

  private

  def record_to_object(record)
    object = Item.new
    object.id = record['id']
    object.name = record['name']
    object.price = record['price']
    object.quantity = record['quantity']
    object
  end
end
