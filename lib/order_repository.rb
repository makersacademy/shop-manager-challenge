require_relative './order'
require_relative './database_connection'

class OrderRepository
  def all
    sql = 'SELECT 	orders.id AS order_id,
                    orders.customer_name,
                    orders.order_date,
                    orders.item_id,
                    items.name AS item_name
                  FROM orders
                  JOIN items 
                  ON items.id = orders.item_id;'
                  
    result_set = DatabaseConnection.exec_params(sql,[])
    
    orders = []

    result_set.each do |record|
      orders << record_to_order_object(record)
    end

    return orders
  end

  # Insert new order 
  # item is a new Order object
  def create(order)
    # Executes the SQL query:

    # INSERT INTO albums (customer_name, order_date, item_id) VALUES($1, $2, $3);
    # Doesn't need to return anything (only creates a record)
  end

  private

  def record_to_order_object(record)
    order = Order.new
    order.id = record["order_id"].to_i
    order.customer_name = record["customer_name"]
    order.order_date = record["order_date"]
    order.item_id = record["item_id"].to_i
    order.item_name = record["item_name"]
    
    return order
  end
end