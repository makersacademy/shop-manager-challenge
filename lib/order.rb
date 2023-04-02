class Order
  attr_accessor :id, :date_placed, :customer_name, :items

  def initialize(id = nil, date_placed= nil, customer_name= nil)
    @id = id 
    @date_placed = date_placed 
    @customer_name = customer_name 
    @items = []
  end

  def ==(other)
    return false unless other.is_a?(Order)
    @id == other.id && @date_placed == other.date_placed && @customer_name == other.customer_name
  end

  def to_s
    "#{@id} Date Placed: #{@date_placed} - Customer name: #{@customer_name}"
  end

end