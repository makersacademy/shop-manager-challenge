require_relative '../database_connection.rb'
require_relative 'item'

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    results_set = DatabaseConnection.exec_params(sql, []) 
    results = results_set.map { |record| convert_to_items(record) }
    return results
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    results_set = DatabaseConnection.exec_params(sql, params)
    return convert_to_items(results_set[0])
  end

  def update_quantity(id)
    item = self.find(id)
    reduce_by_one = item.quantity - 1
    sql = 'UPDATE items SET quantity = $2 WHERE id = $1;'
    params = [id, reduce_by_one]
    DatabaseConnection.exec_params(sql, params)
  end

  private 

  def convert_to_items(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity'].to_i
    return item
  end
end