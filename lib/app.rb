class Application
    def run
    end
    customer_name = gets.chomp
    
    
    order = Order.new
    order.customer_name = customer_name
    order.order_date = Time.now --> formatted
    order.items_to_buy = [1,2,3,4]

    orderrepo = OrderRepository.new
    orderrepo.create(order)
end