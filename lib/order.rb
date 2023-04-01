class Order
  attr_accessor :id, :customer, :date, :items

  def intialize
    @items = [] # this will be an array of Item objects
  end

  def add_item(item)
    @items.push(item)
  end
end
