class Product
    
    attr_accessor :id, :name, :unit_price, :quantity

    def initialize
        @orders = []
    end

end