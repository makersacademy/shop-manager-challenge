# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :item_name, :price, :order_id
  # TODO does order_id need to be initialized as nil?
  # Select an item from id and add the given order_id
  # Two arguments: item_id - number, order_id - number
  def update_order_id(item_id, order_id)
    # Executes the SQL query:
    # UPDATE items SET order_id = $1 WHERE id = $2;

    # Returns nil
  end
end
