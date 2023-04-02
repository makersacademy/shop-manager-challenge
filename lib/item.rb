class Item
  attr_accessor :id, :item_name, :unit_price, :quantity

  def initialize(attributes = {})
    @id = attributes[:id]
    @item_name = attributes[:item_name]
    @unit_price = attributes[:unit_price]
    @quantity = attributes[:quantity]
  end
end
