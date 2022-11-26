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

    sql = 'INSERT INTO orders (customer_name, date_placed) VALUES($1, $2);'
    sql_params = [order.customer_name, order.date_placed]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
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
end