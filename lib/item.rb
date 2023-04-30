class Item
  attr_accessor :id, :name, :unit_price, :quantity

  def out_of_stock
    return @quantity <= 0
  end
end