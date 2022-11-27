class PrintOrders

  def print_orders(order_repository, io)
    io.puts "Here's a list of all shop orders:"
    orders = order_repository.all
    orders.each { |order|
      io.puts "##{order.id} #{order.customer_name} Order Date: #{order.order_date} Item: #{order.item_name}"
    }
  end
end