require_relative 'order'

class OrderRepository
  # return array of Order object and the corresponding item name string
  def all_with_item
    sql = 'SELECT 
              orders.id, orders.customer_name, order_date, item_id, items.name
            FROM orders
            JOIN items ON orders.item_id = items.id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders_with_item = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id'].to_i
      orders_with_item << [order, record['name']]
    end
    return orders_with_item
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id)
            VALUES ($1, $2, $3)'
    sql_params = [order.customer_name, order.order_date, order.item_id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
