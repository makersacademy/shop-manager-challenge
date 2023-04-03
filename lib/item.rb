class Item 
  attr_accessor :id, :name, :price, :quantity

  def initialize(id = nil, name = nil, price = nil, quantity = nil)
    @id = id 
    @name = name 
    @price =  price
    @quantity =  quantity

  end

  def ==(other)
    return false unless other.is_a?(Item)
    @id == other.id && @name == other.name && @price == other.price && @quantity == other.quantity
  end
end