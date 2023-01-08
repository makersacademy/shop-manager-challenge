class Item
  attr_accessor :id, :name, :unit_price, :quantity

  def initialize(attributes = [nil] * 4)
    @id, @name, @unit_price, @quantity = attributes
    @attributes = [@id, @name, @unit_price, @quantity]
  end

  def ==(other)
    @attributes = other.attributes
  end
  
end
