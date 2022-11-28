require_relative 'order'
require_relative 'item_order'

class OrderRepository
  
  def fill(unfilled)
    filled = Order.new
    filled.id = unfilled['id']
    filled.customer = unfilled['customer']
    filled.date = unfilled['date']
    filled.item_id = unfilled['item_id']
    filled
  end

  def all
    sql = 'SELECT orders.id, orders.customer, orders.date, item_id 
          FROM orders
          JOIN items_orders ON items_orders.order_id = orders.id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders_array = []
    result_set.each do |order|
      orders_array << fill(order)
    end
    orders_array
  end

  def add(info, items)
    sql = 'INSERT INTO orders (customer, date) VALUES ($1, $2);'
    params = [info.customer, info.date]
    DatabaseConnection.exec_params(sql, params)
    
    sql1 = 'SELECT id FROM orders WHERE customer = $1 AND date = $2;'
    params1 = [info.customer, info.date]
    result = DatabaseConnection.exec_params(sql1, params1)
    order_id = result[0]['id']

    items.each do |item_id|
      sql2 = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
      params2 = [item_id, order_id]
      DatabaseConnection.exec_params(sql2, params2)
    end
  end
end
