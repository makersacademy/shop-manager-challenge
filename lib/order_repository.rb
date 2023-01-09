require_relative './order'


class OrderRepository

  # Selecting all records
  # No arguments
  def all
    sql ='SELECT id, customer_name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      orders.push(record_to_order_object(record))
    end
    return orders

  end

  def create(order)
    sql = 'INSERT INTO 
          orders (customer_name, date, item_id)
            VALUES($1, $2, $3);'
    sql_params = [order.customer_name, order.date, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def record_to_order_object(record)
    order = Order.new

    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.date = record['date']
    order.item_id = record['item_id'].to_i

    return order
  end
end

