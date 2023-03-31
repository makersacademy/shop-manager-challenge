class Order
  ## Order class includes more attributes to be able to map foreign table information directly into it
  attr_accessor :id, :order_time, :item_id, :customer_id, :customer_name, :item_name
end
