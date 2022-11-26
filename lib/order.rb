class Order
  attr_accessor :id, :customer_name, :date_placed, :items_in_order 
  def initialize
    @items_in_order = []
  end
end