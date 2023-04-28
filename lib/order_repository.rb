require_relative './order'

class OrderRepository
  def all
    sql = 'SELECT id, customer_name, date_placed, shop_item_id FROM orders;'
    
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []
    result_set.each do |record|
      orders << create_order(record)
    end
    return orders
  end

  private

  def create_order(record)
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.date_placed = record['date_placed']
    order.shop_item_id = record['shop_item_id']
    return order
  end
end
