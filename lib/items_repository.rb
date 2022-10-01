require_relative './items'

class ItemRepository
  def all
    items = []
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      items << record_to_item_object(record)
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  private

  def record_to_item_object(record)
    item = Item.new

    item.id = record['id']
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']

    item
  end
end