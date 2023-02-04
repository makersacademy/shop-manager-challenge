class Order
  attr_accessor :id, :customer_name, :date, :items

  def initialize(items = [])
    @items = items
  end

  # sums up all the price of all items
  def total_price
    total = 0
    @items.each do |item|
      total += item[:price] * item[:quantity]
    end
    return total
  end
end
