require_relative './item'
require_relative './order'

class ItemRepository
  def all
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.item_price = record['item_price']
      item.item_quantity = record['item_quantity']

      items << item
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);'
    sql_params = [item.item_name, item.item_price, item.item_quantity]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end
