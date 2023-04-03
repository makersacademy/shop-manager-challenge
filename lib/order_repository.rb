require_relative "./order"

class OrderRepository
  def all
    orders = []
    sql = "SELECT orders.id, orders.customer_name, orders.order_date, items.name
          FROM items
          JOIN items_orders ON items_orders.item_id = items.id
          JOIN orders ON items_orders.order_id = orders.id"

    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      order = Order.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.order_date = record["order_date"]
      order.item = record["name"]

      orders << order
    end

    return orders
  end

  def create(order, item_id)
    sql = "INSERT INTO orders (customer_name, order_date) VALUES ($1, $2) RETURNING id;"
    params = [order.customer_name, order.order_date]
    result_set = DatabaseConnection.exec_params(sql, params)
    # Get the last insert id, this is used in the join table. 
    order_id = result_set.first['id']
    
    # Insert a new record in the join table to link the order with an item.
    sql_join = "INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)"
    DatabaseConnection.exec_params(sql_join, [item_id, order_id])
    return nil
  end
end