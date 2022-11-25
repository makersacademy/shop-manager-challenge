require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT orders.id, orders.customer_name, orders.date_placed, items.name FROM orders JOIN orders_items ON orders.id = orders_items.order_id JOIN items ON items.id = orders_items.item_id ORDER BY id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_orders = []
    result_set.each do |record|
      same_order = all_orders.select { |order| order.id == record['id'] }
      if same_order.empty?
        order = Order.new
        order.id = record['id']
        order.customer_name = record['customer_name']
        order.date_placed = record['date_placed']
        order.items << record['name']
        all_orders << order
      else
        same_order[0].items.push(record['name'])
      end
    end
    all_orders
  end

  def create(order,quantity,item_id)
    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES ($1, $2);'
    params = [order.customer_name, order.date_placed]
    result = DatabaseConnection.exec_params(sql, params)
    return if not_enough?(quantity,item_id)
    update_quantity(quantity,item_id)
    update_join_table(item_id)
  end

  def not_enough?(quantity,item_id)
    if current_quantity(item_id) < quantity
      puts "We only have #{current_quantity(item_id)} left in stock"
      true
    else
      false  
    end
  end

  def current_quantity(item_id)
    sql = 'SELECT quantity FROM items WHERE id = $1'
    params = [item_id]
    result = DatabaseConnection.exec_params(sql,params)
    result[0]['quantity'].to_i
  end

  def update_quantity(quantity,item_id)
    sql = 'UPDATE items SET quantity = $1 WHERE id = $2;'
    params = [current_quantity(item_id) - quantity, item_id]
    DatabaseConnection.exec_params(sql,params)
  end

  def update_join_table(item_id)
    sql = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    order_id = new_order_id
    params = [order_id, item_id]
    DatabaseConnection.exec_params(sql,params)
  end
  
  def new_order_id
    sql = 'SELECT MAX(Id) FROM orders;'
    new_order_id = DatabaseConnection.exec_params(sql,[])
    new_order_id[0]['max']
  end

end
