require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Order.new(record['customer_name'], record['date'])
      order.id = record['id'].to_i
      
      orders << order
      end
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES($1, $2);'
    params = [order.customer_name, order.date]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_items_by_order_id(id)
    sql = 'SELECT items.id, items.name, items.unit_price, items.quantity
      FROM items 
      JOIN items_orders ON items_orders.item_id = items.id
      JOIN orders ON items_orders.order_id = orders.id
      WHERE orders.id = $1;'

    result = DatabaseConnection.exec_params(sql, [id])
    item = Item.new(result.first['name'], result.first['unit_price'],result.first['quantity'] )

    
    item.orders = []
    result.each do |record|
      order = Order.new(record['customer_name'],record['date'])

      item.orders << order
      end
    return item
    end
end