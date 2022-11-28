require_relative './order'

class OrderRepository

  def all

    sql = 
    'SELECT orders.id, orders.customer_name, orders.date, items.name AS item_name 
    FROM orders JOIN items_orders  ON orders.id = items_orders.order_id 
    JOIN items ON items.id = items_orders.item_id 
    ORDER BY id;'
   
    result_set = DatabaseConnection.exec_params(sql,[])

    all_orders = []

    result_set.each do |record|
      get_all_items_in_order = all_orders.select { |order| order.id == record['id'] }

      if get_all_items_in_order.empty? then all_orders << record_to_order_object(record)
      else get_all_items_in_order.first.items.push(record['item_name'])
      end 
    end

    return all_orders

    # Returns an array of Order objects.

  end 

  def create(order,item_id)

    sql = 'INSERT INTO orders (customer_name, date) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date]

    result_set = DatabaseConnection.exec_params(sql,sql_params)
    join_order_to_items(item_id)

  end 

  private

  def record_to_order_object(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name'] 
    order.date = record['date']
    order.items << record['item_name']

    return order
  end

  def join_order_to_items(item_id)
    sql = 'INSERT INTO items_orders (order_id, item_id) VALUES ($1, $2);'
    order_id = find_new_order_id
    params = [order_id, item_id]
    DatabaseConnection.exec_params(sql,params)

  end

  def find_new_order_id
    sql = 'SELECT MAX(Id) FROM orders;'
    new_order_id = DatabaseConnection.exec_params(sql,[])
    new_order_id[0]['max']
  end

end 
