require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end

    items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    result.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      return item
    end
  end

  # Gets all the items in a specific order
  def find_by_order(order_id) # params for order_id will be $1
    sql = 'SELECT items.id, items.name, items.price, items.quantity
    FROM items
    JOIN items_orders ON items_orders.item_id = items.id
    JOIN orders ON items_orders.order_id = orders.id
    WHERE orders.id = $1;'
    params = [order_id]

    result_set = DatabaseConnection.exec_params(sql, params)

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end

    items
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
  params = [item.name, item.price, item.quantity]

  DatabaseConnection.exec_params(sql, params)
  end

  def update(item) # need to update quantity when an item is added to an order
    sql = 'UPDATE items SET quantity = $1 WHERE id = $2;'
    params = [item.quantity, item.id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id) # when quantity reaches zero, need to delete item from stock
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
end
