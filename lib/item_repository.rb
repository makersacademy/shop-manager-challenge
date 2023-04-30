require_relative './item'

class ItemRepository

  def all
    query = 'SELECT * FROM items;'
    result = DatabaseConnection.exec_params(query, [])

    items = []

    result.each do |record|
      items << create_item_object(record)
    end

    return items
  end

  def find(id)
    query = 'SELECT * FROM items WHERE id = $1;'
    param = [id]

    result = DatabaseConnection.exec_params(query, param)[0]

    return create_item_object(result)
  end

  def create(item)
    query = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(query, params)
  end

  private 

  def create_item_object(record)
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    return item
  end
end
