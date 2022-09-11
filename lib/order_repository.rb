class OrderRepository
  def all
    sql = "SELECT * FROM orders;"
    order_list = []
    orders = DatabaseConnection.exec_params(sql, [])
    orders.each do |row|
      order = Order.new
      order.id = row['id']
      order.customer_name = row['customer_name']
      order.order_date = row['order_date']
      order_list << order
    end
    order_list
  end
end