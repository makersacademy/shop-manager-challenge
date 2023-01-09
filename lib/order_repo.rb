require_relative 'order'

class OrdersRepository
  def all
    orders = []
    sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      print record
      order = Order.new

      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_choice = record['item_choice']
      orders << order
    end
    return orders
  end

  def add(customer_name, date, item_choice)
    sql = "INSERT INTO orders (customer_name, date, item_choice) VALUES ('#{customer_name}', '#{date}', #{item_choice});"
    title_to_add = DatabaseConnection.exec_params(sql,[])
  end
end