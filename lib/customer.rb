class Customer
  attr_accessor :id, :name

  def initialize
    @orders = []
  end

  def orders
    @orders
  end
end
