class Order
  attr_accessor :id, :customer_name, :date
  def initialize(customer_name, date)
    @customer_name = customer_name
    @date = date
  end
end
