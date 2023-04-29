require_relative 'database_connection'
require_relative 'order'

class OrderRepository
  def initialize
    @orders = []
  end

  def all
    sql = "SELECT id, customer_name, date, item_id FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |record|
      @orders << single_order(record)
    end
    return @orders
  end

  def create(customer_name, date, item_id)
    sql = "INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);"
    params = [customer_name, date, item_id]
    DatabaseConnection.exec_params(sql, params)
  end

  private

  def single_order(record)
    order = Order.new
    order.id = record["id"]
    order.customer_name = record["customer_name"]
    order.date = record["date"]
    order.item_id = record['item_id']
    return order
  end

end
