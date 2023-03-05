require_relative "./order"
require_relative "./database_connection"

class OrderRepository

  def all
    result_set = DatabaseConnection.exec_params("SELECT * FROM orders",[])
    orders_list = []
    result_set.each do |record|
      order = Order.new
      order.id, order.customer_name = record["id"], record["customer_name"]
      order.date, order.item_id = record["date"], record["item_id"]
      orders_list << order
    end
    return orders_list
  end

  def create(new_order) # new_order is an instance of Order class
    query = "INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3)"
    sql_params = [new_order.customer_name, new_order.date, new_order.item_id]
    DatabaseConnection.exec_params(query, sql_params)
    return nil
  end

end
