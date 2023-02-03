class Order
  attr_accessor :id, :customer_name, :placed_date, :items

  def initialize
   @items = [] 
  end
end
