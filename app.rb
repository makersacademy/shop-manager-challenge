# # file: app.rb
require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative 'lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run(item_repository = ItemRepository.new, order_repository = OrderRepository.new)
    @item_repository = item_repository
    @order_repository = order_repository
    
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?
            \n1 = list all shop items\n2 = create a new item
            \n3 = list all orders\n4 = create a new order"
    user_choice = @io.gets.chomp
    while true do
      case user_choice
        when "1"
          @io.puts "Here is the list of all items:"
          @item_repository.all.each do |item|
              @io.puts "##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
          end
          break
        when "2"
            item = Item.new
            @io.puts "Please enter new item name."
              item.name = @io.gets.chomp
            @io.puts "Please enter new item price."
              item.price = @io.gets.chomp
            @io.puts "Please enter new item quantity."
              item.quantity = @io.gets.chomp
            item_repository = ItemRepository.new
            item_repository.create(item)
            break
        when "3"
          @io.puts "Here is the list of all orders:"
          @order_repository.all.each do |order|
              @io.puts "##{order.id} #{order.customer_name} - Date: #{order.date}"
          end
          break
        when "4"
          order = Order.new
          @io.puts "Please enter customer name."
            order.customer_name = @io.gets.chomp
          @io.puts "Please enter date."
            order.date = @io.gets.chomp
          order_repository = OrderRepository.new
          order_repository.create(order)
          break

        
        else
          @io.puts "Please choose 1, 2, 3 or 4."
          user_choice = @io.gets.chomp
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
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end

