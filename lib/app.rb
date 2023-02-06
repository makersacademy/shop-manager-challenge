require_relative 'item_repository'
require_relative 'order_repository'
require_relative 'database_connection'

class Application
  
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager_test')
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    while true
    @io.puts "Welcome to the shop manager program!"
    @io.puts "What do you want to do?"
    @io.puts "1 - list all shop items"
    @io.puts "2 - create a new item"
    @io.puts "3 - list all orders"
    @io.puts "4 - create a new order"

    input = @io.gets.chomp

    if input == '1'
      @io.puts "Here's a list of all shop items:"
      items = @item_repository.all
      items.each { |item| @io.puts "##{item.id} #{item.name} - unit price #{item.unit_price} - quantity #{item.quantity}"}

    elsif input == '2'
      new_entry = ItemRepository.new
      new_item = Item.new
      @io.puts "Please enter name of item"
      new_item.name = @io.gets.chomp
      @io.puts "Please enter unit price of item"
      new_item.unit_price = @io.gets.chomp
      @io.puts "Please enter quantity needed"
      new_item.quantity = @io.gets.chomp

      new_entry.create(new_item)

      @io.puts "New item: #{new_item.name} - unit price: #{new_item.unit_price} - quantity: #{new_item.quantity}"

    elsif input == '3'
      @io.puts "Here's a list of all orders:"
      orders = @order_repository.all
      orders.each { |order| @io.puts "##{order.id} #{order.customer_name} - date #{order.date} - item_id #{order.item_id}"}
    
    elsif input == '4'
      new_entry = OrderRepository.new
      new_order = Order.new
      new_order.date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @io.puts "Please enter customer name"
      new_order.customer_name = @io.gets.chomp
      @io.puts "Please enter item_id"
      new_order.item_id = @io.gets.chomp

      new_entry.create(new_order)
      @io.puts "New order: customer name #{new_order.customer_name} - date #{new_order.date} - item_id #{new_order.item_id}"
    end
  end
  end
end


# the below will be executed when running 'ruby app.rb'
# if __FILE__ == $0
#   app = Application.new(
#     'shop_manager',
#     Kernel,
#     ItemRepository.new,
#     OrderRepository.new
#   )
#   app.run
# end