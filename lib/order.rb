class Order
  def initialize(customer:, date:)
    @customer = customer
    @date = date
  end
  attr_accessor :customer, :date, :id, :item
end