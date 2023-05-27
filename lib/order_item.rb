class OrderItem
  attr_accessor :id, :order_id, :item_id, :order, :item

  def initialize
    @order = nil
    @item = nil
  end
end