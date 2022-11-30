require_relative './order'

class OrderRepository
  def all
    sql = 'SELECT orders.order_id, 
                  orders.customer_name, 
                  orders.order_date, 
                  items.item_name, 
                  items.unit_price
    FROM orders
    INNER JOIN items
    ON orders.item_id = items.item_id;'

    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.order_id = record['order_id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_name = record['item_name']
      order.unit_price = record['unit_price']

      orders << order
    end

    orders
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, item_id, order_date) VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.item_id, order.order_date]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end
