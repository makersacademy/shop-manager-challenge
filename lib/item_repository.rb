require_relative './item'
require_relative './order_repository'

class ItemRepository

  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []
    result_set.each do |record|
      item = from_record_to_item(record)
      items << item
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil if result_set.to_a.length.zero?
    record = result_set[0]
    item = from_record_to_item(record)
    return item
  end

  def find_with_orders(id)
    sql = 'SELECT items.id,
                  items.name,
                  items.unit_price,
                  items.quantity,
                  orders.id AS order_id,
                  orders.customer,
                  orders.date
          FROM items
          JOIN items_orders ON items_orders.item_id = items.id
          JOIN orders ON items_orders.order_id = orders.id
          WHERE items.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil if result.to_a.length.zero?
    record = result[0]
    item = from_record_to_item(record)
    result.each do |record|
      item.orders << from_record_to_order(record)
    end
    return item
  end

  def create(item)
    sql = 'INSERT into items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private

  def from_record_to_item(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity'].to_i
    return item
  end  

  def from_record_to_order(record)
    order = Order.new
    order.id = record['order_id'].to_i
    order.customer = record['customer']
    order.date = record['date']
    return order
  end
end
