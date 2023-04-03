class Order
  def initialize(customer_name, item, order_id = 0)
    @customer_name = customer_name
    @item = item
    @order_id = order_id
  end

  def customer_name
    @customer_name
  end

  def item
    @item
  end

  def order_id
   @order_id
  end
end