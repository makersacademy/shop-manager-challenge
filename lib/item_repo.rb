require_relative './item'
require_relative './database_connection'
require 'pg'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, unit_price, quantity, order_id FROM items;'
    DatabaseConnection.connect('database_orders_test')
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      item.order_id = record['order_id']

      items << item
    end 

    return items
    # Returns an array of orditemer objects.
  end

      # Select a single record
    # Given the id in argument(a number)
  def find(id) 
    sql = 'SELECT id, name, unit_price, quantity, order_id FROM items WHERE id = $1'
    sql_params = [id]


    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    item.order_id = record['order_id']
    
    return item

  end 

  def create(item)

    sql = 'INSERT INTO items (name, unit_price, quantity, order_id) VALUES ($1, $2, $3, $4) RETURNING id, name, unit_price, quantity, order_id'
    sql_params = [item[:name], item[:unit_price], item[:quantity], item[:order_id]]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil if result_set.ntuples.zero?

    record = result_set[0]

    return nil if record.nil? 

    new_item = Item.new
    new_item.id = record['id'].to_i
    new_item.name = record['name']
    new_item.unit_price = record['unit_price']
    new_item.quantity = record['quantity']
    new_item.order_id = record['order_id'] 

    new_item
  end
end