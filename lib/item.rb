class Item
  attr_accessor :id, :name, :price, :quantity, :orders

  def intialize
    @orders = []
  end
end
