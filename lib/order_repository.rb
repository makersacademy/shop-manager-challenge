require_relative "./order"

class OrderRepository
  def all
    # returns an array of Order objects with items
    order_sql = "SELECT id, customer_name, order_date FROM orders ORDER BY id;"
    order_result = DatabaseConnection.exec_params(order_sql, [])

    orders = []

    order_result.each do |order_record|
      order = Order.new
      order.id = order_record["id"].to_i
      order.customer_name = order_record["customer_name"]
      order.date = order_record["order_date"]

      # Gets items by order.id
      item_sql = "SELECT items.name, items.unit_price, orders_items.quantity
                  FROM orders 
                    JOIN orders_items ON orders_items.order_id = orders.id
                    JOIN items ON orders_items.item_id = items.id
                  WHERE orders.id = $1;"
      params = [order.id]
      item_result = DatabaseConnection.exec_params(item_sql, params)

      # Pushes each item to 'items' array
      items = []

      item_result.each do |item_record|
        item = Hash.new
        item[:name] = item_record["name"]
        item[:price] = item_record["unit_price"].to_f
        item[:quantity] = item_record["quantity"].to_i

        items << item
      end

      order.items = items

      orders << order
    end

    return orders
  end

  # Creates a new order
  def create_order(customer_name, items, item_repo)
    order_sql = "INSERT INTO orders (customer_name) VALUES ($1) RETURNING id;"
    order_id = DatabaseConnection.exec_params(order_sql, [customer_name])[0]["id"].to_i
    items.each do |item|
      item_sql = "INSERT INTO orders_items (order_id, item_id, quantity) VALUES ($1, $2, $3);"
      params = [order_id, item[:item_id], item[:quantity]]
      DatabaseConnection.exec_params(item_sql, params)
      item_repo.update_stock(item[:item_id], item[:quantity], "-")
    end
  end

  # removes order from 'orders' table
  def delete_order(id)
    sql = "DELETE FROM orders WHERE id = $1;"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end
