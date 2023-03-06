require_relative 'lib/items_repository'
require_relative 'lib/orders_repository'


class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, terminal, items_repository, orders_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.

    puts 'Welcome to the shop management program!'
    puts 'What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order'
  
    input = gets.chomp
    
  
    case input 
      when '1'
        all_items = @items_repository.all
      
        puts "Here are our items"
        all_items.each do |item|
          puts " #{item.id} - #{item.name} - Unit price: £#{item.price} - Quantity: #{item.quantity}"

        end
    
      when '2'
        item = Items.new
  
  
        @terminal.puts "What is the name of the item?"
        item_name = gets.chomp
        
        @terminal.puts "What is the price of the item?"
        item_price = gets.chomp
        
        @terminal.puts "What is the item quantity?"
        item_quantity = gets.chomp
  
        item.name = item_name      
        item.price = item_price 
        item.quantity = item_quantity
        
        @items_repository.create(item) 
        
        @terminal.puts "Item Recorded"
  
  
  
  
    when '3'
      all_orders = @orders_repository.all
  
      puts "Here are all our orders!"
      all_orders.each do |order|
        puts " #{order.id} - #{order.customer_name} - Order Date: #{order.order_date} - Item Id: #{order.item_id}"
      end
  
    when '4'
        order = Orders.new
        @terminal.puts "What is the name of the customer?"
        customer_name = gets.chomp
        
        @terminal.puts "Date of order? (yyyy-mm-dd format)"
        order_date = gets.chomp
        
        @terminal.puts "what is the item id?"
        item_id = gets.chomp
        
        order.customer_name = customer_name      
        order.order_date = order_date
        order.item_id = item_id
        
        @orders_repository.create(order) 
        @terminal.puts "Order Recorded"
  
    end 
  end
end
  

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager_challenge_test',
    Kernel,
    ItemsRepository.new,
    OrdersRepository.new
  )
  app.run
end


