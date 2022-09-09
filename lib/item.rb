class Item
  def initializer(name:, price:, stock:)
    @name = name
    @price = price
    @stock = stock
  end
  attr_accessor :name, :price, :stock, :id
end