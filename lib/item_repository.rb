require_relative 'item'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items ORDER BY id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      all_items << item
    end
    all_items
  end
  
  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def list_of_item_names
    sql = 'SELECT name FROM items ORDER BY id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_items_list = []
    result_set.each do |record|
      all_items_list << record['name']
    end
    all_items_list
  end
end
