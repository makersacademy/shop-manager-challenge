require_relative './order'
require_relative './item'

class OrderRepo
  def all
    orders = []

    sql = 'SELECT * FROM orders;'

    results = DatabaseConnection.exec_params(sql, [])

    results.each do |result|
      orders << new_order(result)
    end
    return orders
  end

  def create_order(order)
    params = [order.customer_name, order.order_date]

    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);"

    DatabaseConnection.exec_params(sql, params)
  end

  def fetch_items(order_id)
    items = []
    
    sql = 'SELECT * FROM items
            JOIN items_orders_join ON items_orders_join.item_id = items.id
            JOIN orders ON items_orders_join.order_id = orders.id
              WHERE orders.id = $1;'
  
    results = DatabaseConnection.exec_params(sql,[order_id])

    results.each do |result|
      items << fetch_item(result)
    end
    
    return items
  end

  def add_item_to_order(item_id, order_id)
    params = [item_id, order_id]

    sql = 'INSERT INTO items_orders_join (item_id, order_id)
          VALUES ($1, $2);'

    DatabaseConnection.exec_params(sql, params)
  end

  private 

  def new_order(result)
    order = Order.new
  
    order.id = result['id']
    order.customer_name = result['customer_name']
    order.order_date = result['order_date']
    order.items = fetch_items(order.id)

    return order
  end

  def fetch_item(result)
    item = Item.new

    item.id = result['id']
    item.name = result['name']
    item.unit_price = result['unit_price']
    item.quantity = result['quantity']

    return item
  end
end
