class OrderItem
  attr_accessor :id, :order_id, :item_id, :order, :item, :quantity

  def initialize
    @order = nil
    @item = nil
    @quantity = 0
  end
end