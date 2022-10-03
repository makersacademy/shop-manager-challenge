require_relative "item.rb"

class ItemRepository

  def all
    sql = 'SELECT id, item_name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end
  end


  def create(item)
    sql = ‘INSERT INTO items (item_name, price, quantity) VALUES($1, $2, $3)’
    sql_params = [item.item_name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end