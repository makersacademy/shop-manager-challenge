require '../lib/order'
require '../lib/item'

class OrderRepository
  def all
    query = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(query, [])
    orders = []
    result.each do |order|
        new_order = Order.new
        new_order.id = order['id']
        new_order.order_date = order['order_date']
        new_order.customer_name = order['customer_name']
        orders << new_order
    end
    return orders
  end

  def create(customer_name, items)
    items = items.map(&:to_i)
    time = Time.new
    now = time.strftime("%Y-%m-%d")
    num = self.all.length
    id = num += 1
    new_order = Order.new
    new_order.customer_name = customer_name
    new_order.order_date = now
    new_order.id = id
    items.each do |item|
      new_item = Item.new
      new_item.id = item
      new_item.name = item_name(item)
      new_item.unit_price = item_price(item)
      new_item.quantity = item_quantity(item)
      query = 'UPDATE items SET quantity $2 WHERE id = $3;'
      params = [(new_item.quantity - 1), new_item.id]
      DatabaseConnection.exec_params(query, params)
      query = 'INSERT INTO items_orders (item_id, order_id) VALUES($4, $5);'
      params = [new_item.id, new_order.id]
      DatabaseConnection.exec_params(query, params)
      new_order.items << new_item
    end
    puts "Order created and item quantities updated"
  end

  def item_name(num)
    query = 'SELECT name FROM items WHERE id = $1;'
    params = [num]
    result = DatabaseConnection.exec_params(query, params)
    result['name']
  end

  def item_price(num)
    query = 'SELECT unit_price FROM items WHERE id = $1;'
    params = [num]
    result = DatabaseConnection.exec_params(query, params)
    result['price']
  end

  def item_quantity(num)
    query = 'SELECT quantity FROM items WHERE id = $1;'
    params = [num]
    result = DatabaseConnection.exec_params(query, params)
    result['quantity']
  end
end
