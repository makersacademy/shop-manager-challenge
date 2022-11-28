require_relative './item'
require_relative './database_connection'

class ItemRepository
  def initialize(io = Kernel)
    @io = io
  end
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []
    result_set.each { |result|
      item = Item.new
      item.id = result["id"].to_i
      item.name = result["name"]
      item.unit_price = result["unit_price"][1..-1].to_i
      item.quantity = result["quantity"].to_i

      items << item
    }
    items.each { |item| @io.puts "#{item.id} - #{item.name} £#{item.unit_price}.00 #{item.quantity}"}
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT * FROM items WHERE id = $1;'
    params = [id]

    item = Item.new
    result = DatabaseConnection.exec_params(sql,params)
    item.id = result.first["id"].to_i
    item.name = result.first["name"]
    item.unit_price = result.first["unit_price"][1..-1].to_i
    item.quantity = result.first["quantity"].to_i

    return item

    # Returns a single Item object.
  end

  def find_by_order(id)
  # Executes the SQL query:
    sql = 'SELECT items.id, items.name, items.unit_price, items.quantity FROM items JOIN items_orders ON items.id = items_orders.item_id JOIN orders ON items_orders.order_id = orders.id WHERE orders.id = $1;'
    params = [id]

    items = []
    result_set = DatabaseConnection.exec_params(sql,params)
    result_set.each { |result|
      item = Item.new
      item.id = result["id"].to_i
      item.name = result["name"]
      item.unit_price = result["unit_price"][1..-1].to_i
      item.quantity = result["quantity"].to_i

      items << item
    }
    items.each { |item| puts item}
  # Returns an array of Item objects from a single order
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  # user inputs item name, price, quantity
  # Executes the SQL query:
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql,params)

    return nil
  # Returns nothing
  end

  def update(item)
  # user item name, price, quantity

  # Executes the SQL query:
    sql = 'UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name, item.unit_price, item.quantity, item.id]

    DatabaseConnection.exec_params(sql,params)
    return nil
  # Returns nothing
  end

  def delete(id)
  # Executes the SQL query:
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)
    return nil
  # Returns nothing
  end
end
