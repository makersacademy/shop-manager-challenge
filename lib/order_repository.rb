require 'order'
require 'item'
require 'item_order'

class OrderRepository
  def all_order
    sql = 'SELECT orders.id, orders.customer_name, 
                             orders.date_ordered, 
                             items.name 
                      FROM orders
                        JOIN items_orders ON items_orders.order_id = orders.id
                        JOIN items ON items_orders.item_id = items.id
                        ORDER BY orders.id ASC;'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    orders = []
    result_set.each do |record|
      get_an_order_record(record)
      orders << get_an_order_record(record)
    end
    return orders
  end
  

  def create_order(order)
    sql = 'INSERT INTO orders (customer_name, date_ordered) VALUES ($1, $2);'
    sql_params = [order.customer_name, order.date_ordered]
    
    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def add_item_order_id(item_order)
    sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
    sql_params = [item_order.item_id, item_order.order_id]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  private 

  def get_an_order_record(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date_ordered = record['date_ordered']
    order.item_name = get_an_item(record)
    return order
  end

  def get_an_item(record)
    item = Item.new
    item.name = record['name']
    return item.name 
  end
end