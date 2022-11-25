require_relative 'item'
require_relative 'order'

class ItemRepository
  def all
  end

  def find_with_orders(item_id)
    sql = 'SELECT items.id AS "id", items.item_name AS "item_name", orders.date AS "date", orders.customer_name AS "customer_name" FROM orders JOIN items ON orders.item_id = items.id WHERE items.id = $1;'
    params = [item_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    
    first_record = result_set[0]
    item = Item.new
    item.id = first_record["id"]
    item.item_name = first_record['item_name']
    item.orders = []

    result_set.each do |record|
      order = Order.new
      order.date = record['date']
      order.customer_name = record['customer_name']

      item.orders << order
    end
    return item
  end
end