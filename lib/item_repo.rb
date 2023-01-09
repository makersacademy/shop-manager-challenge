require_relative 'item'

class ItemsRepository
  def all
    items = []
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      print record
      item = Item.new

      item.id = record['id']
      item.item_name = record['item_name']
      item.quantity = record['quantity']
      item.unit_price = record['unit_price']
      items << item
    end
    return items
  end

  def add(item_name, quantity, unit_price)
    sql = "INSERT INTO items (item_name, quantity, unit_price) VALUES ('#{item_name}', '#{quantity}', #{unit_price});"
    title_to_add = DatabaseConnection.exec_params(sql,[])
  end
end