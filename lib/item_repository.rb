require_relative './item'

class ItemRepository
  # Selecting all items
  # No arguments
  def all
    items = []
    #defining sql query string
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    #executes sql query and passes sql string and an empty array as an argument
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |inst|
      #for each instance it creates a new instance and assigns corresponding atributes
      item = Item.new

      item.id = inst['id']
      item.name = inst['name']
      item.unit_price = inst['unit_price']
      item.quantity = inst['quantity']

      items << item
    end

    return items
  end

  def find(id)
    items = []
    sql = 'SELECT name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    result.each do |inst|
      item = Item.new

      item.id = inst['id']
      item.name = inst['name']
      item.unit_price = inst['unit_price']
      item.quantity = inst['quantity']

      return item
    end
  end

  def create(item)
    
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)

    return nil

  end
end