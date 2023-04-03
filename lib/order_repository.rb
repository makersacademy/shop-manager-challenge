require_relative 'order'

class OrderRepository 

  def all
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |row|
      order = Order.new
      order.id = row['id'].to_i
      order.date_placed = row['date_placed']
      order.customer_name = row['customer_name']
   
      orders << order
    end
    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (date_placed, customer_name) VALUES ($1, $2)'
    DatabaseConnection.exec_params(sql, [order.date_placed, order.customer_name])
  end

  def create_with_items(order)
    create(order)
    order_id = current_serial_id()

    #my order items is my intermidiate table to link my orders and items
    order.items.each do |item|
      sql = 'INSERT INTO orders_items(order_id, item_id) VALUES ($1, $2)'
      #here my using my last id created when I created a new order
      DatabaseConnection.exec_params(sql, [order_id, item.id])
    end
  end

  def current_serial_id
    #it return my last id created for my table orders.
    sql = "SELECT currval(pg_get_serial_sequence('orders','id')) as order_id;"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set[0]['order_id'].to_i
  end

  def find_with_items(id)
    #returns my order with all items added to my order.
    sql = 'SELECT o.id as order_id, o.date_placed, o.customer_name, 
    i.id as item_id, i.name, i.price FROM ORDERS as o 
    join orders_items as oi on o.id = oi.order_id 
    join items as i on i.id = oi.item_id where o.id = $1;'

    result_set = DatabaseConnection.exec_params(sql, [id])

    first_row = result_set[0]
    #Order will be the same for all lines, because I'm filtering by id
    #So I'm creating an order first and then I will include my items.
    order = Order.new(first_row['order_id'].to_i, first_row['date_placed'], first_row['customer_name'])

    result_set.each do |row|
      item = Item.new 
      item.id = row['item_id'].to_i
      item.name = row['name']
      item.price = row['price'].to_f
      order.items << item
    end
    order 
  end

  def all_with_items
    sql = 'SELECT o.id as order_id, o.date_placed, o.customer_name, 
    i.id as item_id, i.name, i.price, i.quantity FROM ORDERS as o 
    join orders_items as oi on o.id = oi.order_id 
    join items as i on i.id = oi.item_id;'

    result_set = DatabaseConnection.exec_params(sql, [])

    order_hash = {}

    result_set.each do |row|
      order_id = row['order_id'].to_i
      order = nil
      #I only create a order once, because the database will return multiple lines with same order id.
      #Using order_hash I will link each item with the correct order
      if order_hash.include?(order_id)
        order = order_hash[order_id]
      else
        order = Order.new(order_id, row['date_placed'], row['customer_name'])
        order_hash[order_id] = order
      end

      item = Item.new 
      item.id = row['item_id'].to_i
      item.name = row['name']
      item.price = row['price'].to_f
      item.quantity = row['quantity'].to_i
      order.items << item
    end
    order_hash.values 
  end
end
