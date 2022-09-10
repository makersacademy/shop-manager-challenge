require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    while true do
      @io.puts "What do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order\n  exit"
      input = @io.gets.to_i
      case input
      when 1
        items = @item_repository.all
        @io.puts "Here's a list of all shop items:"
        items.each do |item|
          @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
        end
      when 2
        item = Item.new
        item.name = @io.gets.chomp
        item.unit_price = @io.gets.to_i
        item.quantity = @io.gets.to_i
        @item_repository.create(item)
      when 3
        orders = @order_repository.all
        @io.puts "Here's a list of all orders:"
        orders.each do |order|
          @io.puts "##{order.id} - Customer: #{order.customer} - Date: #{order.date}"
        end
      when 4
        order = Order.new
        order.customer = @io.gets.chomp
        order.date = @io.gets.chomp
        @order_repository.create(order)
      when 0
        break
      else
        @io.puts "Please enter a number from 1 to 4"
      end
    end
    
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end