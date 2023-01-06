require_relative 'order'

class OrderRepository
  def all
    sql = 'SELECT * FROM orders ORDER BY id;'
    results = DatabaseConnection.exec_params(sql, [])
    orders = []
    results.each do |record|
      orders << record_to_object(record)
    end
    orders
  end

  def create(order)
    sql = "INSERT INTO orders (date, customer_name) VALUES ($1, $2);"
    params = [order.date, order.customer_name]
    DatabaseConnection.exec_params(sql, params)
  end

  private

  def record_to_object(record)
    object = Order.new
    object.id = record['id']
    object.customer_name = record['customer_name']
    object.date = record['date']
    object
  end
end
