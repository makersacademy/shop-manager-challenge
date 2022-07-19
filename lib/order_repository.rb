require_relative './order'
require_relative './item'
require_relative './item_repository'


class OrderRepository
  def all
    sql = 'SELECT id, customer, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.map do |record|
      order = from_record_to_order(record)
      orders << order
    end  
    return orders
  end


  def find(id)
    sql = 'SELECT id, customer, date FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    return nil if result_set.to_a.length == 0
    record = result_set[0]
    order = from_record_to_order(record)
    return order
  end

  def find_with_items(id)
    sql = 'SELECT orders.id,
                  orders.customer,
                  orders.date,
                  items.id AS item_id,
                  items.name AS item,
                  items.unit_price,
                  items.quantity AS quantity_available
          FROM orders
          JOIN items_orders ON items_orders.order_id = orders.id
          JOIN items ON items_orders.item_id = items.id
          WHERE orders.id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil if result.to_a.length == 0
    record = result[0]
    order = from_record_to_order(record)
    result.map do |record|
      item = from_record_to_item(record)
      order.items << item
    end  
    return order
  end

  def create(order)
    sql = 'INSERT into orders (customer, date) VALUES ($1, $2);'
    params = [order.customer, order.date]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private 

  def from_record_to_order(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer = record['customer']
    order.date = record['date']
    return order
  end

  def from_record_to_item(record)
    item = Item.new
    item.id = record['item_id'].to_i
    item.name = record['item']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity_available'].to_i
    return item
  end  
end