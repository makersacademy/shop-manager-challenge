class Item 
  def initialize(name, unit_price, quantity, item_id = 0)
   @name = name
   @unit_price = unit_price
   @quantity = quantity
   @item_id = item_id
  end

  def name
    @name
  end

  def unit_price
    @unit_price
  end

  def quantity
    @quantity
  end

  def item_id
    @item_id
  end
end