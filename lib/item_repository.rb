require_relative './item'
require_relative './order'

class ItemRepository

  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      items << unpack_record(record)
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    unpack_record(record)
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(item)
    sql = 'UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;'
    params = [item.name, item.price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  # def find_by_order(item_id)
  #   sql = 'SELECT orders.id AS order_id,
  #                 orders.customer,
  #                 orders.date,
  #                 items.id AS item_id,
  #                 items.name,
  #                 items.price,
  #                 items.quantity
  #         FROM items
  #         JOIN items_orders ON items_orders.order_id = items.id
  #         JOIN orders ON items_orders.item_id = orders.id
  #         WHERE orders.id = $1;'
  #   params = [item_id]
  #   result_set = DatabaseConnection.exec_params(sql, params)
  #   record = result_set[0]

  #   item = Item.new
  #   item.id = record['id'].to_i
  #   item.name = record['name']
  #   item.price = record['price'].to_f
  #   item.quantity = record['quantity'].to_i

  #   result_set.each do |record|
  #     order = Order.new
  #     order.customer = record['customer']
  #     order.date = record['date']
  #     item.orders << order
  #   end
  # end

  private

  def unpack_record(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.price = record['price'].to_f
    item.quantity = record['quantity'].to_i
    return item
  end

end
