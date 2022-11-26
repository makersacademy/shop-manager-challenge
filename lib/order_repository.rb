require_relative "database_connection"
require_relative "order"

class OrderRepository
  def all
    sql_query = "SELECT id, customer_name, date_placed FROM orders;"
    query_result = DatabaseConnection.exec_params(sql_query, [])

    orders = []
    query_result.each do |record|
      orders << unpack_order_record(record)
    end
    return orders
  end

  def create(order, items)
    fail "An order must have items" if items == []

    # Create the order record in the orders table
    order_creation_query =
    "INSERT INTO orders (id, customer_name, date_placed) VALUES ($1, $2, $3);"
    params = [order.id, order.customer_name, order.date_placed]
    DatabaseConnection.exec_params(order_creation_query, params)

    # Update the join table to keep track of the items in the order
    join_update_records = items.map { |item| "(#{item.id}, #{order.id})" }
    join_update_query = "INSERT INTO items_orders (item_id, order_id) VALUES "
    join_update_query += join_update_records.join(", ") + ';'
    DatabaseConnection.exec_params(join_update_query, [])
  end

  private

  def unpack_order_record(record)
    order = Order.new
    order.id = record["id"].to_i
    order.customer_name = record["customer_name"]
    order.date_placed = record["date_placed"]
    return order
  end
end
