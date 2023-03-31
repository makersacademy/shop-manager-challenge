require_relative './database_connection'
require_relative './item'

class ItemRepository

  def all
    # Returns an array of Item objects
    sql = 'SELECT * FROM items'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |row|
      item = Item.new
      item.name = row['name']
      item.unit_price = row['unit_price'].to_f.round(2)
      item.quantity = row['quantity'].to_i
      items << item
    end

    return items
  end

  def create(item)
    # Inserts an Item object into the DB
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    # Returns nil
  end

  def print_all
    # Returns an array of strings formatted to print with puts
  end
end