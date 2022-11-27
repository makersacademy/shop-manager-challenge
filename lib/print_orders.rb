class PrintOrders

  def initialize(order_repository, io)
    @io = io
    @order_repository = order_repository
  end

  def print_orders
    @io.puts "Here's a list of all shop orders:"
    orders = @order_repository.all
    print_orders_formatter(orders)
  end

  private
  
  def print_orders_formatter(orders)
    orders.each { |order|
      @io.puts "##{order.id} #{order.customer_name} Order Date: #{order.order_date} Item: #{order.item_name}"
    }
  end

end