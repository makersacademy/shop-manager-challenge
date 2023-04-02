require_relative 'lib/shop_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application
  def initialize(database_name, shop_repository, order_repository, io = Kernel)
    DatabaseConnection.connect(database_name)
    @io = io
    @shop_repository = shop_repository
    @order_repository = order_repository
  end

  def print_out_all_items
    items_for_sale = @shop_repository.all_items
    items_for_sale.each_with_index { |item, index| 
    @io.puts "#{index + 1}: #{item.name} - Unit Price: £#{item.price.to_f / 100} - Quantity: #{item.qty}"}
  end

  def print_out_order(id)
    customer_order = @order_repository.single_order_with_items(id)
    @io.puts "Customer name: #{customer_order.customer}" 
    @io.puts "Order placed on: #{customer_order.date_of_order}"
    @io.puts "Items ordered:"
    customer_order.order_items.each { |item| @io.puts item}
    @io.puts ""
  end

  def print_out_all_orders
    @order_repository.all_orders.each { |customer|
      print_out_order(customer.id)
    }
  end

  def run
    # print_out_all_orders
    # print_out_order(@order_repository.all_orders[0].id)
    # print_out_all_items
    # print @order_repository.all_orders[0].customer
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    ShopRepository.new,
    OrderRepository.new,
    io = Kernel
  )
  app.run
end
