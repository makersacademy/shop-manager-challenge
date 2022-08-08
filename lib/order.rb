class Order
  attr_accessor :id, :customer_name, :date, :item_id

  def initialize(customer_name, date, item_id)
    @customer_name = customer_name
    @date = date
    @item_id = item_id
  end
end