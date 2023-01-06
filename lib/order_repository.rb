require_relative "./order"

class OrderRepository
  def all
    sql = "SELECT id, customer_name, date, item_id FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id']

      orders << order
    end
    return orders
  end

  def find(id)
    sql = "SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]

    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id']

    return order
  end

  def create(order)
    sql = "INSERT INTO orders (customer_name, date, item_id) VALUES($1, $2, $3);"
    params = [order.customer_name, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def update(order)
    sql = "UPDATE orders SET customer_name = $1, date = $2, item_id = $3 WHERE id = $4;"
    params = [order.customer_name, order.date, order.item_id, order.id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def delete(order_id)
    sql = "DELETE FROM orders WHERE id = $1;"
    params = [order_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end
