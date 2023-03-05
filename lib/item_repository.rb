class ItemRepository
  require_relative 'item'
  
  def all
    items = []
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price'].to_i
      item.quantity = record['quantity'].to_i
      items << item
    end 
    return items
  end
end
