class Order
  attr_accessor :id, :customer_name, :placed_date, :items

  def initialize
    @placed_date = Time.now.strftime("%Y-%m-%d")
   @items = [] 
  end
end
