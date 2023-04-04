require_relative './item'
require_relative './order'

class ShopManager
  def initialize
    @items = []
    @orders = []
  end

  def create_item(item_name, unit_price, quantity)
    item = Item.new(item_name: item_name, unit_price: unit_price, quantity: quantity)
    @items << item
  end
end
