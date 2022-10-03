require_relative './item'

class ItemRepository

  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |record|
      item = Item.new(
        record['name'],
        record['unit_price'],
        record['quantity'].to_i,
      )
      item.id = record['id'].to_i
      items << item
      end
    items
  end

  def create(item)

    sql = 'INSERT INTO items (name, unit_price, quantity) 
    VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end

end
