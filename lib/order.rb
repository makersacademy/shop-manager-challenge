class Order
  attr_accessor :id, :date, :customer, :items
  def initialize
    @items = []
  end
end
