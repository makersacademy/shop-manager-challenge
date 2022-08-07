require_relative 'item'
require_relative 'database_connection'

class ItemRepository
  def all
    sql = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_item(record) }
  end

  def find_item(id)
    sql = 'SELECT * FROM items
      WHERE id = $1'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_item(record) }[0]
  end    

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, qty)
      VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.qty]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  def update(id, item)
    sql = 'UPDATE items
      SET (name, unit_price, qty) = ($1, $2, $3)
      WHERE id = $4;'
    params = [item.name, item.unit_price, item.qty, id]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  private

  def make_item(record)
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.qty = record['qty']
    item
  end
end
