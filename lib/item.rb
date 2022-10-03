class Item
  attr_accessor :id, :name, :price, :quantity, :orders
  
  def initialize
    @orders = []
  end
end
