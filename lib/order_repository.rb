class OrderRepository

  # Selecting all records
  # No arguments
  def all
    sql = "SELECT * FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    return result_set_to_orders(result_set)
  end

  # Adding an order to the table
  # order: Order - order to add to table
  def create(order)
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1,$2)'
    sql_params = [order.customer_name, order.date]
    
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  # Find all the orders attached to an item
  # item_id: int - the id of the item to filter by
  def find_by_item(item_id)
   sql =
    'SELECT
	    orders.id,
	    orders.customer_name,
	    orders.date
	  FROM items
	  JOIN items_orders
	    ON items.id = items_orders.item_id
	  JOIN orders
	    ON items_orders.order_id = orders.id
	  WHERE item_id = $1;'
    sql_params = [item_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return result_set_to_orders(result_set)
  end

  def result_set_to_orders(result_set)
    orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.date = record['date']

      orders << order
    end

    return orders
  end
end