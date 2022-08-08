require_relative "order"

class OrderRepository

  def all 

    sql = 'SELECT orders.id, orders.customer_name, orders.date_order_placed, products.name FROM orders 
           JOIN products ON products.id = orders.product_id;'
    sql_params = []
    
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    orders = []

    result_set.each do |record|

      order = Order.new
      order.id = record["id"]
      order.customer_name = record["customer_name"]
      order.date_order_placed = record["date_order_placed"]
      order.item_ordered = record["name"]

      orders << order

    end

    return orders


  end 


  
  def create(new_order)

    sql = 'INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ($1, $2, $3);' 
    sql_params = [new_order.customer_name, new_order.date_order_placed, new_order.item_ordered]

    DatabaseConnection.exec_params(sql, sql_params)

    return "The order has been created on the database."


  end

  

end