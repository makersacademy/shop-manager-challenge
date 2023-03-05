class Items
  attr_accessor :id, :item_name, :price, :quantity

  def initialize(item_name:nil, price:nil, quantity:nil )
    @id = id
    @item_name = item_name
    @price = price
    @quantity = quantity
  end
end