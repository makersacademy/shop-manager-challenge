require_relative './order'

class OrderRepository

  def all
  
    sql = 'SELECT id, customer_name, placed_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
        
    orders =[]
    result_set.each do |record|
    orders << record_to_order_object(record)
    end

    return orders
  end

  def record_to_order_object(record)
    order = Order.new 
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.placed_date = record['placed_date']
    return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, placed_date) VALUES($1, $2);'

    sql_params = [order.customer_name, order.placed_date]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def find_with_items(id)
    sql = 'SELECT items.id, items.name 
            FROM items
            JOIN items_orders ON items_orders.item_id = items.id
            JOIN orders ON items_orders.order_id = orders.id
            WHERE orders.id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)
        order = Order.new
        order.id = result.first['id']
        # order.name = result.first['name']

        result.each do |record|
          item = Item.new
          item.id = record['item_id']
          order.items << item
        end
        return order 
  end
  
end 