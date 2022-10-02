require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    results_set = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    
    results_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']

      orders << order
    end

    return orders
  end

  def create_with_items(new_order)
    sql = 'INSERT INTO orders
    (customer_name, order_date, item_id)
            VALUES ($1, $2, (SELECT id from items WHERE id = $3));'

    params = [new_order.customer_name, new_order.order_date, new_order.item_id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
