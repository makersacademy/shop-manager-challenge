class Order
  attr_accessor :id, :customer_name, :date_placed, :items, :quantity
  def initialize
    @items = []
  end
end
