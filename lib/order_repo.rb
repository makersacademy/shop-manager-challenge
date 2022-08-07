require_relative 'order'
require_relative 'database_connection'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(sql ,[])
    result.map { |record| make_order(record) }
  end

  def find_order(id)
    sql = 'SELECT * FROM orders
      WHERE id = $1'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_order(record) }[0]
  end    

  def order_with_items(id)
    sql = 'SELECT items.id, items.name, items.unit_price, items_orders.item_qty
      FROM items
        JOIN items_orders ON items_orders.item_id = items.id
        JOIN orders ON items_orders.order_id = orders.id
        WHERE orders.id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    order = find_order(1)    
    result.each { |item| order.items << make_item(item) }
    order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date_placed)
      VALUES ($1, $2);'
    params = [order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  def update(id, order)
    sql = 'UPDATE orders
      SET (customer_name, date_placed) = ($1, $2) 
      WHERE id = $3;'
    params = [order.customer_name, order.date_placed, id]
    DatabaseConnection.exec_params(sql, params)
    return
  end

  private

  def make_order(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order
  end

  # make item object to append to order
  # NOTE: quantity is order quantity and not stock quantity
  def make_item(record)
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.qty = record['item_qty']
    item
  end
end