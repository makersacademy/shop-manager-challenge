require '/Users/saritaradia/Desktop/Projects/shop-manager-challenge/lib/item.rb'

class ItemRepository
  def all
    sql = 'SELECT id, item_name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      items << item
    end
    items
  end

  def find(id)
    sql = 'SELECT id, item_name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)
    record = result[0]
    item = Item.new
    item.id = record['id']
    item.item_name = record['item_name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    item
  end

  def create(item)
      sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES ($1, $2, $3);'
      sql_params = [item.item_name, item.unit_price, item.quantity]
      DatabaseConnection.exec_params(sql, sql_params)
  end

  # def update(item) Not required
  #   sql = 'UPDATE items SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
  #   sql_params = [item.item_name, item.unit_price, item.quantity]
  #   DatabaseConnection.exec_params(sql, sql_params)
  # end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end
end