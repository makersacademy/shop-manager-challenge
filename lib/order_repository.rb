require_relative './order'
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

      items_sql = 'SELECT items.name, items_orders.item_count FROM items JOIN items_orders ON items_orders.item_id = items.id 
        JOIN orders ON orders.id = items_orders.order_id
        WHERE orders.id = $1;'
      items_result = DatabaseConnection.exec_params(items_sql,[record['id']])  

      items_result.each do |record|
        item = [record['name'],record['item_count'].to_i]
        order.items << item
      end

      orders << order
    end
    return orders
  end

  def create(order)
    DatabaseConnection.connection.transaction do
      # Create new order in orders table
      sql = 'INSERT INTO orders (customer_name, placed_date) VALUES ($1,$2) RETURNING id;'
      params = [order.customer_name,order.placed_date]

      result_set = DatabaseConnection.exec_params(sql,params)

      order_id = result_set[0]['id'].to_i

      order.items.each do |item| # => ["Apple", 2]
        # extract item id
        item_sql = 'SELECT id, quantity FROM items WHERE name = $1;'
        item_result = DatabaseConnection.exec_params(item_sql,[item[0]])

        # check if the order item exists in the stock
        item_id = 0
        item_result.each { |result| item_id = result['id'].to_i }
        fail "#{item[0]} does not exist in the stock" if item_id == 0

        # check if item is out of stock
        item_quantity = item_result[0]['quantity'].to_i
        fail "#{item[0]} is out of stock" if item[1] > item_quantity

        # Create links between order and items with count
        items_orders_sql = 'INSERT INTO items_orders (order_id, item_id, item_count) VALUES ($1, $2, $3);'
        DatabaseConnection.exec_params(items_orders_sql,[order_id,item_id,item[1]])

        # Decrease the quantity of the item after an order is placed
        quantity_sql = 'SELECT quantity FROM items WHERE name = $1;'
        quantity_result = DatabaseConnection.exec_params(quantity_sql,[item[0]])
        item_quantity = quantity_result[0]['quantity'].to_i
        updated_quantity = item_quantity - item[1]

        # p updated_quantity
        update_sql = 'UPDATE items SET quantity = $1 WHERE name = $2;'
        DatabaseConnection.exec_params(update_sql,[updated_quantity,item[0]])
      end
    end
    return nil
  end
end
