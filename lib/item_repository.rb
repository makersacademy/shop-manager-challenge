require 'item'
class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_i
      item.quantity = record['quantity'].to_i

      items << item
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set.first

    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price'].to_i
    item.quantity = record['quantity'].to_i

    return item
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)'
    sql_params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end