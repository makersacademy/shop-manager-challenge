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

      sql = 'SELECT orders.id AS order_id, orders.customer_name, orders.date_placed, shop_items.id AS shop_item_id, shop_items.name, shop_items.unit_price, shop_items.quantity
              FROM orders
              JOIN shop_items_orders ON orders.id = shop_items_orders.order_id
              JOIN shop_items ON shop_items.id = shop_items_orders.shop_item_id
              WHERE orders.id = $1;'
      sql_params = [order.id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      result_set.each do |record|
        order.items_in_order << record_to_item_object(record)
      end

    end
    return orders
  end

  def create(order)
    # adds the order to orders table
    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date_placed]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def add_item_to_new_order(order, item)
    # this method is called when adding items to a newly created order
    check_if_item_in_stock(item)

    add_record_to_joins_table(order, item)

    reduce_stock_quantity_by_one(item)
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

  def add_record_to_joins_table(order, item)
    sql = 'INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES ($1, $2);'
    sql_params = [item.id, order.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def reduce_stock_quantity_by_one(item)
    sql = 'UPDATE shop_items SET quantity = quantity - 1 WHERE id = $1;'
    sql_params = [item.id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end
end