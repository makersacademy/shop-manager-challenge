class Order
  attr_accessor :id, :customer, :date_of_order, :order_items

  def initialize
    @order_items = []
  end
end
