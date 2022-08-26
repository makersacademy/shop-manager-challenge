require_relative './item.rb'

class ItemRepository

  def all
    sql = 'SELECT * FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []
    result_set.each do |record|
      item = Item.new(record['name'],record['unit_price'].to_i,record['quantity'].to_i)
      
      item.id = record['id'].to_i
      items << item
      end
    items
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_orders_by_item_id(id)
    sql = 'SELECT orders.id, orders.customer_name, orders.date
      FROM orders 
      JOIN items_orders ON items_orders.order_id = orders.id
      JOIN items ON items_orders.item_id = items.id
      WHERE items.id = $1;'

    result = DatabaseConnection.exec_params(sql, [id])

      order = Order.new(result.first['customer_name'], result.first['date'])
      
      order.items = []
      result.each do |record|
      item = Item.new(record['name'],record['unit_price'], record['quantity'])
      
      order.items << item
      end
    return order
    end
end