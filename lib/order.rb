class Order
  attr_accessor :id, :customer_name, :order_date

  def initialize(id: nil, customer_name: nil, order_date: nil)
    @id = id
    @customer_name = customer_name
    @order_date = order_date
  end
end