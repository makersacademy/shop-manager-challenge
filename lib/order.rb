class Order
  attr_accessor :id, :customer_name, :date, :item_id, :attributes

  def initialize(attributes = [nil] * 4)
    @id, @customer_name, @date, @item_id = attributes
    @attributes = [@id, @customer_name, @date, @item_id]
  end

  def ==(other)
    @attributes = other.attributes
  end
end
