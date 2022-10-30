require_relative 'order'
require_relative 'item'
require_relative 'item_repository'

class OrderRepository
  def all
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
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    params = [order.customer_name, order.date]

    DatabaseConnection.exec_params(sql, params)
  end

  def find_items_in_order(id)
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
    order = find_items_in_order(order_id)
    item_repo = ItemRepository.new
    item_to_add = item_repo.find(item_id)
    order.items << item_to_add

    return order
  end
end