class Order
  attr_accessor :id, :customer, :order_date, :items
  def initialize
    @items = []
  end
end
