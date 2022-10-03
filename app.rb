require_relative 'lib/database_connection'
require_relative 'lib/order_repository.rb'
require_relative 'lib/item_repository.rb'
DatabaseConnection.connect('shop_manager_test')


class Application

   def initialize(database_name, io, order_repository, item_repository)
     DatabaseConnection.connect('shop_manager_test')
     @io = io
     @order_repository = order_repository
     @item_repository = item_repository
   end
 
   def run
      @io.puts "\n"
      @io.puts "Welcome to the shop management program!"
      @io.puts "\n"
      @io.puts "What would you like to do?"
      @io.puts "1 = List all shop items"
      @io.puts "2 = create a new item"
      @io.puts "3 = lists all orders"
      @io.puts "4 = create a new order"
      @io.puts "\n"
      @io.puts "Enter your choice:"
      
         option = @io.gets.chomp

      if option == "1"
         @item_repository.all.each do |item|
           @io.puts  "#{item.name} - Unit Price: #{item.unit_price}"
         end
         
      
      elsif option == "2"
        item = Item.new
        item.name = 'sanitiser'
        item.unit_price = "20"
        item.quantity = "7"
        @item_repository.create(item)  
        @io.puts "new item: #{item.name} added to stock" 

      elsif option == "3"
        @order_repository.all.each do |order|
            @io.puts  "#{order.customer} - date ordered: #{order.date}"
        end
      elsif option == "4"
        order = Order.new
        order.customer = 'Hana'
        order.item_id = "2"
        order.date = "2022-03-10"
        @order_repository.create(order)  
        @io.puts "new order creatd on: #{order.date}" 
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
     OrderRepostiory.new,
     ItemRepository.new
   )
   app.run
 end

end