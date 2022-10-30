# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :item_name, :price, :order_id
  # TODO does order_id need to be initialized as nil?
  # Select an item from id and add the given order_id
  # Two arguments: item_id - number, order_id - number
  def update_order_id(order_id, item_id)
    sql = 'UPDATE items SET order_id = $1 WHERE id = $2;'
    sql_params = [order_id, item_id]
    DatabaseConnection.exec_params(sql, sql_params)

    nil
  end
end
