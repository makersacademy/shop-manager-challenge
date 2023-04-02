require_relative 'database_connection'
require_relative 'order'

class OrderRepository 
  def all_orders
    sql = 'SELECT * FROM orders'
    result = DatabaseConnection.exec_params(sql, [])
    output = []

    result.each do |line| 
      item = Order.new
      item.id = line["id"]; item.customer = line["customer"]
      item.date_of_order = line["date_of_order"]
      output << item
    end
    return output
  end

  def single_order(id)
    params = [id]; sql = 'SELECT * FROM orders WHERE id=$1'
    result = DatabaseConnection.exec_params(sql, params)

    item = Order.new
    item.id = result.first["id"]; item.customer = result.first["customer"]
    item.date_of_order = result.first["date_of_order"]
    return item
  end
end
