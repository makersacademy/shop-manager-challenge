class Order
  attr_accessor :id, :customer_name, :date_placed, :items
  def initialize
    @items = []
  end
end
