require_relative './order'

class OrderRepository
  def all 
    orders = []
    # section below creates an order object and loads in the attributes for id, customer_name
    # and date_placed and fills the array of orders 
    sql = 'SELECT id, customer_name, date_placed FROM orders;'
    sql_params = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.each do |record|
      orders << record_to_order_object(record)
    end
    # section below adds all of the relevant items to each order
    orders.each do |order|

      sql = 'SELECT orders.id AS order_id, orders.customer_name, orders.date_placed, shop_items.id AS shop_item_id, shop_items.name, shop_items.unit_price, shop_items.quantity, shop_items_orders.quantity AS quantity_added_to_order
              FROM orders
              JOIN shop_items_orders ON orders.id = shop_items_orders.order_id
              JOIN shop_items ON shop_items.id = shop_items_orders.shop_item_id
              WHERE orders.id = $1;'
      sql_params = [order.id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      result_set.each do |record|
        quantity = record['quantity_added_to_order']
        order.items_in_order << [record_to_item_object(record), quantity]
      end

    end
    # section below returns an array of order objects but only if there are items in that
    # order, so if an order record is created but no items are associated with
    # that order then it will not be showing in the orders array
    return orders
  end

  def create(order)
    # adds the order to orders table
    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date_placed]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def add_item_to_new_order(order, item, quantity)
    # this method is called when adding items to a newly created order
    check_if_item_in_stock(item)

    check_if_enough_stock(item, quantity)

    add_record_to_joins_table(order, item, quantity)

    reduce_stock_quantity_by_num_inputted(item, quantity)
  end

  private 

  def record_to_order_object(record)
    order = Order.new 
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    
    return order
  end

  def record_to_item_object(record)
    item = ShopItem.new 
    item.id = record['shop_item_id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    return item
  end

  def check_if_item_in_stock(item)
    sql = 'SELECT name, unit_price, quantity FROM shop_items WHERE id = $1;'
    sql_params = [item.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    raise 'Item not in stock' if record['quantity'] == '0'
  end

  def check_if_enough_stock(item, num_added_to_order)
    sql = 'SELECT name, unit_price, quantity FROM shop_items WHERE id = $1;'
    sql_params = [item.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    raise 'Not enough stock to fulfil order' if record['quantity'].to_i < num_added_to_order
  end

  def add_record_to_joins_table(order, item, quantity)
    sql = 'INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.id, order.id, quantity]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def reduce_stock_quantity_by_num_inputted(item, num_added_to_order)
    sql = 'UPDATE shop_items SET quantity = quantity - $1 WHERE id = $2;'
    sql_params = [num_added_to_order, item.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
end