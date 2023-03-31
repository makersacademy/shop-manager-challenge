require_relative './database_connection'
require_relative './item'

class ItemRepository

  def all
    # Returns an array of Item objects
    items = []

    select_all.each do |row|
      item = Item.new
      item.id = row['id'].to_i
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
    return nil
    # Returns nil
  end

  def print_all
    # Returns an array of strings formatted to print with puts
    formatted_strings = []
    select_all.each do |row|
      fstring = " ##{row['id']} #{row['name']} - Unit price: #{row['unit_price']} - Quantity: #{row['quantity']}"
      formatted_strings << fstring
    end

    return formatted_strings
  end

  private

  def select_all
    # Returns an array of hashes
    sql = 'SELECT * FROM items'
    DatabaseConnection.exec_params(sql, [])
  end
end