require_relative 'order'
require_relative 'item'
require_relative 'item_repository'
require_relative 'database_connection'

class OrderRepository
  def all
  # Returns all orders in database
    sql = 'SELECT id, customer_name, date FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])

    orders = []

    result.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']

      orders << order
    end
    return orders
  end

  def find(id)
  # Finds order in database by ID and returns order
    sql = 'SELECT id, customer_name, date FROM orders WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    order = Order.new
    result.each do |record|
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
    end
    return order
  end

  def create(order)
  # Creates new order in database
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    params = [order.customer_name, order.date]

    DatabaseConnection.exec_params(sql, params)
  end

  def find_items_in_order(id)
  # Finds order in database and adds items to list
    sql = 'SELECT
          orders.id AS order_id,
          customer_name,
          date,
          items.id AS item_id,
          name,
          price,
          quantity
        FROM
          orders
          JOIN items_orders ON items_orders.order_id = orders.id
          JOIN items ON items_orders.item_id = items.id
          WHERE orders.id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    order = Order.new
    order.id = result.first['order_id']
    order.customer_name = result.first['customer_name']
    order.date = result.first['date']

    result.each do |record|
      item = Item.new
      item.id = record['item_id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      order.items << item
    end
    return order
  end

  def add_items_to_order(order_id, item_id)
  # Adds items to existing order in database
    order = find(order_id)
    item_repo = ItemRepository.new
    item_to_add = item_repo.find(item_id)
    order.items << item_to_add
    sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
    params = [item_id, order_id]
    DatabaseConnection.exec_params(sql, params)
    return order
  end
end