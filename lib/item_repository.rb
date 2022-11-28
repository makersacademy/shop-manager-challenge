class ItemRepository
  def initialize
  end

  def all
    sql = 'SELECT id, item_name, item_price, item_stock FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
      items = []
      result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.item_price = record['item_price']
      item.item_stock = record['item_stock']
      items << item
      end
    return items
  end

  def find(id)
    sql = 'SELECT id, item_name, item_price, item_stock FROM items WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    item = Item.new
    item.id = record['id'].to_i
    item.item_name = record['item_name']
    item.item_price = record['item_price']
    item.item_stock = record['item_stock']

    return item
  end
end
