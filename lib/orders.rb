class orders
    def initialize(id = 0 order = 0, customer_name = "", order_date = 0)
      @id, @order, @customer_name, @order_date = id,
    end
    attr_accessor :order, :customer_name, :order_date
  end