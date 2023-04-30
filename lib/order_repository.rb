require_relative 'order'
require_relative 'database_connection'
require_relative 'item_repository'

class OrderRepository
  def all
    sql = 'SELECT orders.id, orders.customer_name, orders.date_placed,
          items.id AS item_id, items.name FROM orders JOIN items
          ON items.id = orders.item_id;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []
    result_set.each do |record|
      orders << record_to_order(record)
    end
    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ($1, $2, $3);'
    params = [order.customer_name,
              order.date_placed,
              order.item_id]

    item_repo = ItemRepository.new
    item_repo.update_quantity(order.item_id, -1)
    
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private

  def record_to_order(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order.item_id = record['item_id'].to_i
    order.item_name = record['name']
    return order
  end
end