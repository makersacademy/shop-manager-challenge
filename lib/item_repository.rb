class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = "SELECT * FROM items;"

    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.unit_price = record['unit_price'].to_f
      item.quantity = record['quantity'].to_i

      items << item
    end

    return items
  end

  # Adding an item to the table
  # item: Item - item to add to table
  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES ($1,$2,$3)'
    sql_params = [item.name,item.unit_price,item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  # Find all the items attached to an order
  # order_id: int - the id of the order to filter by
  def find_by_order(order_id)
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
	# WHERE order_id = 1;

    # Returns an array of item objects. 
  end
end
