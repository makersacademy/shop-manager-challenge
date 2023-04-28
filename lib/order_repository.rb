require 'order'

class OrderRepository

  def all
    query = 'SELECT * FROM orders;'
    result = DatabaseConnection.exec_params(query, [])

    orders = []

    result.each do |record|
      orders << create_order_object(record)
    end

    return orders
  end

  def find(id)
    query = 'SELECT * FROM orders WHERE id = $1;'
    param = [id]

    result = DatabaseConnection.exec_params(query, param)[0]

    return create_order_object(result)
  end

  def create(order)
    query = 'INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);'
    params = [order.customer_name, order.date, order.item_id]

    DatabaseConnection.exec_params(query, params)
  end

  private 

  def create_order_object(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']

    return order
  end
end
