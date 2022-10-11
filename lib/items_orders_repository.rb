require_relative '../lib/item.rb'
require_relative '../lib/order.rb'
require_relative '../lib/items_orders.rb'
require_relative '../lib/database_connection.rb'

class ItemsOrdersRepository
  def create(items_orders)
    sql = 'INSERT INTO items_orders (item_id, order_id) VALUES($1, $2);'
    sql_params = [items_orders.item_id, items_orders.order_id]

    DatabaseConnection.exec_params(sql, sql_params)
  end
end
