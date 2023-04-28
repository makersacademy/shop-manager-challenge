class OrderRepository
  def list
    # query = 'SELECT id, customer_name, date FROM orders;'
    # returns an array of Order objects
  end

  def assign_item(order, item)
    # query = 'INSERT INTO orders_items (order_id, item_id) VALUES ($1, $2);'
    # params = [order.id, item.id]
  end

  def create(order)
    # query = 'INSERT INTO order (customer_name, date) VALUES ($1, $2);'
    # params = [order.customer_name, order.date]
  end
end
