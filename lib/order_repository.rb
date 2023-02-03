require 'order'
class OrderRepository
  def all
    sql = 'SELECT id, customer_name, placed_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql,[])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.placed_date = record['placed_date']

      items_sql = 'SELECT items.name FROM items JOIN items_orders ON items_orders.item_id = items.id 
        JOIN orders ON orders.id = items_orders.order_id
        WHERE orders.id = $1;'
      items_result = DatabaseConnection.exec_params(items_sql,[record['id']])  

      items_result.each do |record|
        order.items << record['name']
      end

      orders << order
    end
    return orders
  end
end
