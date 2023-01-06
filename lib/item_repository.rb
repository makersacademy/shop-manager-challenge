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
