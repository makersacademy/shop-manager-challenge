class Order
    attr_accessor :id, :customer_name, :order_date, :items_to_buy
    def initialize
        @items_to_buy = []
    end
end