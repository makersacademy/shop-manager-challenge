class OrderRepository
  # No arguments

  def all
 sql = 'select id, order_id, customer_name, date_of_order from orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order-order_id = record['order_id']
      order.customer_name = record['customer_name']
      order.date_of_order = record['date_of_order']
      orders << order
    end
    return orders
  end
  end

  # Create an order
  # Takes an Order object and a list of items as arguments
  def create(order, items)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_of_order)
    # VALUES ($1, $2);
    # params = [order.customer_name, order.date_of_order]
    
      ## INSERT INTO items_orders (item_id, order_id)
      ## VALUES ($1, $2)
    # Returns nothing
  end

#   end
#   # Find an order
#   # Takes order id as an argument
#   def find_order(id)
#     # sql = 'SELECT * FROM orders
#     #     WHERE id = $1'
#     # returns order object
#   end

#   # Join - order with items info
#   # Takes order id as an argument
#   def order_with_items(id)
#     # sql = 'SELECT items.name, item.quantity
#     #   FROM items
#     #     JOIN items_orders ON items_orders.item_id = items.id
#     #     JOIN orders ON items_orders.order_id = orders.id
#     #     WHERE orders.id = $1;'

#     # returns an order with items
#   end
# end
