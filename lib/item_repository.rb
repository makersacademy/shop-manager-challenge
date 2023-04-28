require 'item'
require 'database_connection'

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
