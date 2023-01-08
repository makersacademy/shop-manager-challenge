class Orders
  attr_accessor :id, :customer_name, :date, :items

  def initialize
    @items = []
  end
end
