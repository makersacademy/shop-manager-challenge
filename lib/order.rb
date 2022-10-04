class Order
  attr_accessor :id, :customer, :date, :items

  def initialize
    @items = []
  end  
end
