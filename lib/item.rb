class Item
  attr_accessor :id, :title, :price, :stock, :order_id

  def initialize(title: nil, price: nil, stock: nil, id: nil, order_id: nil)
    @id = id
    @title = title
    @price = price
    @stock = stock
    @order_id = order_id
  end
end