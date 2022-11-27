require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, order_date, stock_id FROM orders;'
    result = DatabaseConnection.exec_params(sql, [])
    return populate_order(result)
  end

  def find(id)
    sql = 'SELECT id, customer_name, order_date, stock_id FROM orders WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    order = Order.new

    order.id = result[0]['id']
    order.customer_name = result[0]['customer_name']
    order.order_date = result[0]['order_date']
    order.stock_id = result[0]['stock_id']

    return order
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, stock_id)
    VALUES ($1, $2, $3);'
    sql_params = [order.customer_name, order.order_date, order.stock_id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(id)
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2, stock_id = $3 WHERE id = $4;'
    sql_params = ['new_customer2', '2022-03-03', '1', id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def populate_order(result)
    orders = []
    result.each do |item|
      order = Order.new
      order.id = item['id']
      order.customer_name = item['customer_name']
      order.order_date = item['order_date']
      order.stock_id = item['stock_id']
      orders << order
    end
    return orders
  end
end
