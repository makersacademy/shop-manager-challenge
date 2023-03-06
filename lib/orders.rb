class Orders
  attr_accessor :id, :customer_name, :order_date, :item_id

  def initialize(customer_name: nil, order_date: nil, item_id: nil)
    @id = id
    @customer_name = customer_name
    @order_date = order_date
    @item_id = item_id
  end

end
