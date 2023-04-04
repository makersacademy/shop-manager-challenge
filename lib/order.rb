class Order
  attr_accessor :id, :customer_name, :item_id, :date

  def initialize(id: nil, customer_name:, item_id:, date:)
    @id = id
    @customer_name = customer_name
    @item_id = item_id
    @date = date
  end
end
