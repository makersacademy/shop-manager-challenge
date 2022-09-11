require_relative 'item'

class ItemRepository

  def all
    sql = 'SELECT id, name, unit_price, stock_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_f
      item.stock_quantity = record['stock_quantity'].to_i
      items << item
    end
    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, stock_quantity)
            VALUES ($1, $2, $3)'
    sql_params = [item.name, item.unit_price, item.stock_quantity]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
