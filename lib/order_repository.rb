require_relative './order'
require_relative './item'
require_relative './order_item'

class OrderRepository
  def all_order
    sql = 'SELECT orders.id, orders.customer_name,orders.date, items.name FROM orders
                JOIN orders_items ON orders_items.order_id = orders.id
                JOIN items ON orders_items.item_id = items.id
            ORDER BY orders.id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      orders << get_order_record(record)
    end
    return orders
  end
  
  def create_order(order)
    sql = 'INSERT INTO orders (customer_name) VALUES ($1);'
    sql_params = [order.customer_name]
    
    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def add_order_item_id(order_item)
    sql = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    sql_params = [order_item.order_id, order_item.item_id]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def last_order_id
    sql = 'SELECT id FROM orders;'
    all_id = DatabaseConnection.exec_params(sql, [])
    id = all_id.values.last.join
    return id
  end

  private 

  def get_order_record(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_name = get_item(record)
    return order
  end

  def get_item(record)
    item = Item.new
    item.name = record['name']
    return item.name 
  end
end
