require_relative './lib/item_repository'    
require_relative './lib/order_repository'

class Application

  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat do you want to do?"
    @io.puts "1 = list all shop items\n2 = create a new item"
    @io.puts "3 = list all orders\n4 = create a new order"
    @io.puts "Enter your choice:"
    user_input = @io.gets.chomp
    if user_input == "1"
      @io.puts "Here is the list of items:"
      @item_repository.all.each do |entry|
      @io.puts "* #{entry.id} - #{entry.item_name} - Unit price: #{entry.unit_price} - Quantity: #{entry.quantity}"
      end
    elsif user_input == "3"
      @io.puts "Here is the list of orders:"
      @order_repository.all.each do |entry|
      @io.puts "* #{entry.id} - #{entry.customer_name} - #{entry.item_name} - Order date: #{entry.order_date}"
      end
    elsif user_input == "2"
      new_item = Item.new
      @io.puts "Enter new item name:"
      new_item_name = @io.gets.chomp
      @io.puts "Enter new item unit price:"
      new_item_unit_price = @io.gets.chomp
      @io.puts "Enter new item quantity:"
      new_item_quantity = @io.gets.chomp
      new_item.item_name =  new_item_name
      new_item.unit_price = new_item_unit_price
      new_item.quantity = new_item_quantity
      @item_repository.create(new_item)
    elsif user_input == "4"
      new_order = Order.new
      @io.puts "Enter new customer name:"
      new_customer_name = @io.gets.chomp
      @io.puts "Enter new item name:"
      new_item_name = @io.gets.chomp
      @io.puts "Enter new order date (YYYY-MM--DD):"
      new_order_date = @io.gets.chomp
      new_order.customer_name = new_customer_name
      new_order.item_name = new_item_name
      new_order.order_date = new_order_date
      @order_repository.create(new_order)
    else
      @io.puts "That is an invalid input."
    end
  end
end

# if __FILE__ == $0
#   app = Application.new(
#     'shop_manager',
#     Kernel,
#     OrderRepository.new,
#     ItemRepository.new
#   )
#   app.run
# end