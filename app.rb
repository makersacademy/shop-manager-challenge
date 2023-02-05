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
    menu()
  end

  def menu
    while true do
      @io.puts "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"
      user_input = gets.chomp
      case user_input
      when "1"
        list_items()
      when "2"  
        @io.puts "placeholder: you selected option 2"
      when "3"
        list_orders()
      when "4"
        @io.puts "placeholder: you selected option 4"
      else
        @io.puts "not a valid input, please try again"
        next
      end
      
     end
    end
  end

  def list_items
    @io.puts "\nHere's a list of all shop items:"
    @io.puts "---------------------------------------------------"
    items = @item_repository.all
    items.each_with_index do |item, index|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
    end
    @io.puts "---------------------------------------------------"
    @io.puts " "
  end

  def list_orders
    @io.puts "\nHere's a list of all existing orders:"
    @io.puts "---------------------------------------------------"
    orders = @order_repository.all
    orders.each_with_index do |order, index|
      @io.puts "##{order.id} Date #{order.order_date} - Customer Name: #{order.customer_name}"
    end
    @io.puts "---------------------------------------------------"
    @io.puts " "

  end



if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end