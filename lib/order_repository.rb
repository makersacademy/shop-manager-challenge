class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = "SELECT * FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

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

  # Adding an order to the table
  # order: Order - order to add to table
  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (customer_name, date) VALUES ($1,$2)'
    sql_params = [order.customer_name, order.date]
    
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  # Find all the orders attached to an item
  # item_id: int - the id of the item to filter by
  def find_by_item(item_id)
    # Executes the SQL query:
  #  SELECT 
	#   items.id AS "item_id",
	#   items.name,
	#   items.unit_price,
	#   items.quantity,
	#   orders.id AS "order_id",
	#   orders.customer_name,
	#   orders.date
	# FROM items
	# JOIN items_orders
	#   ON items.id = items_orders.item_id
	# JOIN orders
	#   ON items_orders.order_id = orders.id
	# WHERE item_id = $1;

    # Returns an array of order objects. 
  end
end