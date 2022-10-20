class Order
  attr_accessor :customer_name, :order_date, :id, :items

  def initialize
    @items = []
  end
end
