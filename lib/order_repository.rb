require '../lib/order'

class OrderRepository
  def initialize(io)
    @io = io
  end

  def all
    query = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(query, [])
    orders = []
    result.each do |order|
        new_order = Order.new
        new_order.id = order['id']
        new_order.order_date = order['order_date']
        new_order.customer_name = order['customer_name']
        new_order.item_id = order['item_id']
        orders << new_order
    end
    return orders
  end

  def create
    @io.puts "What is the customer name?"
    name = @io.gets.chomp
    @io.puts "What is the item id?"
    item_id = @io.gets.chomp
    query = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);'
    time = Time.new
    now = time.strftime("%Y-%m-%d")
    params = [name, now, item_id.to_i]
    DatabaseConnection.exec_params(query, params)
    query = 'SELECT quantity FROM items WHERE id = $4;'
    params = [item_id.to_i]
    quantity = DatabaseConnection.exec_params(query, params)
    query = 'UPDATE items SET quantity = $5 WHERE id = $6;'
    params = [quantity.to_i, item_id.to_i]
    DatabaseConnection.exec_params(query, params)
    @io.puts "Order created and quantity updated"
  end
end
