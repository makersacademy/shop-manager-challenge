require_relative 'order'

class OrderRepository
  def list
    # query = 'SELECT id, customer_name, date FROM orders;'
    # returns an array of Order objects
    query = 'SELECT id, customer_name, date FROM orders;'
    entries = DatabaseConnection.exec_params(query, [])
    orders = []
    for entry in entries do
      order = Order.new
      order.id = entry["id"]
      order.customer_name = entry["customer_name"]
      order.date = entry["date"]
      orders << order
    end
    return orders
  end

  def assign_item(order_id, item_id)
    # query = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    # params = [order.id, item.id]
    query = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    params = [order_id, item_id]
    DatabaseConnection.exec_params(query, params)
  end

  def create(order)
    # query = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    # params = [order.customer_name, order.date]
    query1 = 'INSERT INTO orders (customer_name, date) VALUES ($1, $2);'
    params = [order.customer_name, order.date]
    DatabaseConnection.exec_params(query1, params)
    query2 = 'SELECT max(id) FROM orders'
    id = DatabaseConnection.exec_params(query2, []).to_a.first["max"]
    return id
  end

  def return_all_assigned_items
    query = 'SELECT order_id, item_id FROM orders_items'
    entries = DatabaseConnection.exec_params(query, [])
    relationships = []
    for entry in entries do
      relationships << { :order_id => entry["order_id"].to_i, :item_id => entry["item_id"].to_i }
    end
    return relationships
  end
    
end
