class Item
  attr_accessor :name, :unit_price, :quantity, :id, :orders

  def initialize
    @orders = []
  end
end
