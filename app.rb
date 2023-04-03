require_relative 'lib/shop_repository'
require_relative 'lib/order_repository'
require_relative 'lib/shop_item'
require_relative 'lib/order'
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
    items_for_sale.each_with_index do |item, index| 
      @io.puts 
      "#{index + 1}: #{item.name} - Unit Price: £#{item.price.to_f / 100} - Quantity: #{item.qty}"
    end
  end

  def print_out_order(id)
    customer_order = @order_repository.single_order_with_items(id)
    @io.puts "Customer name: #{customer_order.customer}" 
    @io.puts "Order placed on: #{customer_order.date_of_order}"
    @io.puts "Items ordered:"
    customer_order.order_items.each { |item| @io.puts item }
    @io.puts ""
  end

  def print_out_all_orders
    @order_repository.all_orders.each do |customer|
      print_out_order(customer.id)
    end
  end

  def create_new_order
    next_id = @order_repository.number_of_orders + 1
    new_orders = add_items_to_order
    order_list = []
    new_orders.each do |order_item| 
      order_list << [next_id, order_item]
    end
    @io.puts "Enter your name:"
    name = @io.gets.chomp!
    @io.puts "Enter the date (in MMM-DD-YYYY):"
    date = @io.gets.chomp!
    new_order = Order.new; new_order.customer = name
    new_order.date_of_order = date; new_order.order_items = order_list
    result = repo.create_order(new_order)
  end

  def add_items_to_order
    output = []
    while true
      @io.puts "Enter number of item to add: "
      selection = @io.gets.chomp!
      output << selection.to_i
      @io.puts "add again? y/n"
      again = gets.chomp!
      if again.include?("n")
        break
      end
    end
    return output
  end

  def create_new_item
    @io.puts "Enter item name:"
    name = @io.gets.chomp!
    @io.puts "Enter item price:"
    price = @io.gets.chomp!
    @io.puts "Enter item quantity:"
    qty = @io.gets.chomp!
    new_item = ShopItem.new
    new_item.name = name
    new_item.price = price
    new_item.qty = qty
    return new_item
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    selection = @io.gets.chomp!
    case selection
      when "1"
        print_out_all_items
      when "2"
        @shop_repository.create_item(create_new_item)
      when "3"
        print_out_all_orders
      when "4"
        puts "TBC"
      else
        puts "i don't understand..."
    end
    # add_items_to_order  
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
