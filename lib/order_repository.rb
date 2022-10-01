require 'order'
require 'item'

class OrderRepository
  def all_order
    sql = 'SELECT orders.id, orders.customer_name, 
                             orders.date_ordered, 
                             items.name 
                      FROM orders
                          JOIN items_orders ON items_orders.order_id = orders.id
                          JOIN items ON items_orders.item_id = items.id
                          ORDER BY orders.id ASC;'
    result_set = DatabaseConnection.exec_params(sql, [])
  
    orders = []

    result_set.each do |record|
      get_an_order_record(record)
      orders << get_an_order_record(record)
    end
    return orders

    # returns an array of Order object with item name
  end
  
  # Insert a new order record
  # Take an Order object in argument
  def create(order)
    # Executes the SQL query: INSERT INTO orders (customer_name, date_ordered) VALUES ($1, $2);
                  
    # return nothing
  end

  private 

  def get_an_order_record(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date_ordered = record['date_ordered']
    item = Item.new
    item.name = record['name']
    order.item_name = item.name
    return order
  end
end