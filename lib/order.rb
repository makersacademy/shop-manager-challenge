class Order
  attr_accessor :id, :date, :customer_name, :items
  def initialize
    @items = []
  end
end
