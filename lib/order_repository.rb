require 'order'

class OrderRepository

  def all
    result = DatabaseConnection.exec_params('SELECT * FROM orders;', [])
    orders = []
    result.each do |row|
      order = Order.new
      order.id = row['id']
      order.customer_name = row['customer_name']
      order.date_placed = row['date_placed']
      order.item_id = row['item_id']
      orders << order 
    end
    orders
  end
end
