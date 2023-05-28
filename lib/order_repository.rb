require_relative 'order'
require_relative 'item'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date FROM orders;'
    results = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    results.each do |result|
      order = Order.new
      order.customer_name = result['customer_name']
      order.date = result['date']
      
      orders << order
    end
    
    return orders
  end
  
  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES($1, $2) RETURNING id;'
    result = DatabaseConnection.exec_params(sql, [order.customer_name, order.date])
    order_id = result.first['id']
    
    order.items.each do |item|
      sql = 'INSERT INTO items_orders (item_id, order_id) VALUES($1, $2);'
      result = DatabaseConnection.exec_params(sql, [item, order_id])
    end
  end
  
  def find_items_by_order(order_id)    sql = 'SELECT items.id, items.name, items.price, items.quantity
          FROM items 
          JOIN items_orders ON items_orders.item_id = items.id
          JOIN orders ON items_orders.order_id = orders.id
          WHERE orders.id = $1;'
    
    params = [order_id]
    results = DatabaseConnection.exec_params(sql, params)
    items = []
    
    results.each do |result|
      item = Item.new
      
      item.id = result['id']
      item.name = result['name']
      item.price = result['price']
      item.quantity = result['quantity']
      
      items << item
    end
    
    return items
  end
end
