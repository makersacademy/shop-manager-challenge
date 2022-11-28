require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    puts "Welcome to the shop manager!"
    loop do
      puts "What would you like to do?"
      puts "1 - List all shop items"
      puts "2 - Create a new item"
      puts "3 - List all orders"
      puts "4 - Create an order"
      puts "Enter 'STOP' to exit"

      user_input = gets.chomp

      if user_input == "1"
        items = @item_repository.all
        items.each do |item|
          puts "##{item.id} #{item.item} - Price: #{item.price} - Quantity: #{item.quantity}"
        end

      elsif user_input == "2"
        @item_repository.create
        puts "Item created"

      elsif user_input == "3"
        orders = @order_repository.all
        orders.each do |order|
          puts "##{order.id} - Name: #{order.customer_name} - Date: #{order.date}"
        end

      elsif user_input == "4"
        @order_repository.create
      else
        break if user_input == "STOP"
      end
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    "shop_challenge",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end