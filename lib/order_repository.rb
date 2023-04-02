require_relative './order'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.item_id = record['item_id'].to_i
      order.date = record['date']

      orders << order
    end

    return orders
  end

  def find(id)
    # Implement method to find an order by id
  end

  def create(order)
    # Implement method to create a new order
  end

  def update(id, order)
    # Implement method to update an existing order
  end

  def delete(id)
    # Implement method to delete an order by id
  end
end
