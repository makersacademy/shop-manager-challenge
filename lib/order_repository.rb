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
      new_order.customer_name = order['customer_name']
      new_order.order_date = order['order_date']
      orders << new_order
      end
    orders
  end

  def create_order(name, items)
    items.each do |item_id|
      create_links(new_id, item_id)
      update_stock(item_id)
    end
    query = 'INSERT INTO orders (id, customer_name, order_date) VALUES($1, $2, $3);'
    params = [new_id, name, new_date]
    DatabaseConnection.exec_params(query, params)
  end

  def new_id
    self.all.length + 1
  end

  def new_date
    time = Time.new
    return time.strftime('%Y/%m/%d')
  end

  def create_links(id, item_id)
    query = 'INSERT INTO items_orders (item_id, order_id) VALUES($1, $2);'
    params = [item_id, new_id]
    DatabaseConnection.exec_params(query, params)
  end

  def update_stock(item_id)
    query = 'SELECT quantity FROM items WHERE id = $1;'
    params = [item_id]
    result = DatabaseConnection.exec_params(query, params)
    current_stock = (result[0]['quantity'].to_i) - 1
    query = 'UPDATE items SET quantity = $1 WHERE id = $2;'
    params = [current_stock, item_id]
    DatabaseConnection.exec_params(query, params)
  end

  def view_orders
    self.all.each do |order|
      puts("*#{order.id} - #{order.customer_name}: #{order.order_date}*")
    end
  end
end
