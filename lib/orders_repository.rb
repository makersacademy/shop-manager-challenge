# Repository Class
require_relative './orders'
class OrdersRepository
	def all
		sql = 'SELECT * FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    result_set.each do |record|
      order = Orders.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']

      orders << order
    end
      return orders
	end

	def order_made(orders)
    i=0
    orders.each do
      return "##{orders[i].id} #{orders[i].customer_name} - Order date: #{orders[i].order_date} - Item id: #{orders[i].item_id}"
      i+=1
    end
  end

  def find(id)
    sql = "SELECT customer_name, order_date, item_id FROM orders WHERE id = $1"
    result_set = DatabaseConnection.exec_params(sql, [id])

    result_set.each do |record|
      order = Orders.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      order.item_id = record['item_id']
      return order
    end
  end
	def create(order)

		sql = "INSERT INTO orders (customer_name, order_date, item_id) VALUES('#{order.customer_name}', '#{order.order_date}', '#{order.item_id}');"
    result_set = DatabaseConnection.exec_params(sql, [])
    return result_set

	end
end