require_relative "item"
require "pg"

class ItemRepository
  def all
    sql = 'SELECT id, title, price, stock, order_id FROM items;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.title = record['title']
      item.price = record['price']
      item.stock = record['stock']
      item.order_id = record['order_id']

      items << item
    end
    return items

  end

  def find(id)
    sql = 'SELECT id, title, price, stock, order_id FROM items WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    record = result_set[0]
    item = Item.new
    item.id = record['id']
    item.title = record['title']
    item.price = record['price']
    item.stock = record['stock']
    item.order_id = record['order_id']

    return item
  end

  def create(item)
    sql = 'INSERT INTO items (title, price, stock, order_id) VALUES($1, $2, $3, $4);'
    sql_params = [item.title, item.price, item.stock, item.order_id]
    
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(item)
    sql = 'UPDATE items SET title = $1, price = $2, stock = $3, order_id = $4 WHERE id = $5;'
    sql_params = [item.title, item.price, item.stock, item.order_id, item.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end