require 'order'

class OrderRepository
  # Selecting all records
  # No arguments
  
  def all
    all_orders = []
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |entry|
      all_orders << inflate_order(entry)
    end
    return all_orders
    # Returns an array of Student objects.
  end

  # Extra method not required by challenge
  def find(id)
    single_item = []
    sql = 'SELECT * FROM orders WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    entry = result_set[0]
      single_item << inflate_order(entry)
    return single_item
  end

  
  def create(order)
   sql = 'INSERT INTO orders (customer_name, item_name, order_date) VALUES ($1, $2, $3);'
   sql_params = [order.customer_name, order.item_name, order.order_date]
   DatabaseConnection.exec_params(sql, sql_params)
  end



  private

  def inflate_order(entry)
    order = Order.new
    order.id = entry["id"].to_i
    order.customer_name = entry["customer_name"]
    order.item_name = entry["item_name"]
    order.order_date = entry["order_date"]
    return order
  end

end