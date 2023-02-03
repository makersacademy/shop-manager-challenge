class Order
  attr_accessor :id, :customer_name, :order_date, :items

  def initialize
    @items = []
  end
end