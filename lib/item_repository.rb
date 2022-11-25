require_relative './item'

class ItemRepository

  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      items << unpack_record(record)
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    unpack_record(record)
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(item)
    sql = 'UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name, item.price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private
  def unpack_record(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.price = record['price'].to_f
    item.quantity = record['quantity'].to_i
    return item
  end

end