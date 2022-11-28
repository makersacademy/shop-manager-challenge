require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

DatabaseConnection.connect('shop_database_test')

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)

  def initialize(database_name, terminal, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @order_repository = order_repository
    @item_repository = item_repository
   
  end

  def display_options_menu
    
    @terminal.puts '__Main Menu__
    ' 
    @terminal.puts 'Please select an option' 
    @terminal.puts '1 - list all shop items'
    @terminal.puts '2 - create a new item'
    @terminal.puts '3 - list all orders'
    @terminal.puts '4 - create a new order'
    @terminal.puts '5 - exit'
    @terminal.puts 'Enter your choice:'

  end 

  def process(menu_selection)
    
    case menu_selection
      when "1" then show_all_shop_items
      when "2" then create_new_item
      when "3" then show_all_shop_orders
      when "4" then create_new_order
      when "5" then @terminal.puts 'Goodbye!' 
        exit 
      else puts "Input not recognised, please select a valid number"
    end
  end
 
  def show_all_shop_items

    @terminal.puts '_Item Menu_
    '

    all_shop_items = @item_repository.all
    
    all_shop_items.each do |item|
      @terminal.puts "#{item.id} - Name: #{item.name} - Unit Price: £#{item.unit_price} - 
      Quantity: #{item.quantity}"
    end

  end 

  def create_new_item
    item_to_be_created = new_item_info
    item = Item.new
    item.name, item.unit_price, item.quantity = item_to_be_created
    @item_repository.create(item)
    
    @terminal.puts 'New item created!'
  end 

  def new_item_info
    @terminal.puts 'Please enter item name'
    name = @terminal.gets.chomp
    @terminal.puts "Now enter unit price in as a 3 digit number in the format '£.pp' - e.g. 2.35"
    unit_price = @terminal.gets.chomp
    @terminal.puts "Please enter current stock as a number"
    quantity = @terminal.gets.chomp
    [name,unit_price,quantity]
  end

  def show_all_shop_orders
    @terminal.puts 'Here are all currently stored shop orders'

    all_shop_orders = @order_repository.all
    
    all_shop_orders.each do |order|
      @terminal.puts "#{order.id} - Customer name: #{order.customer_name} - Date: #{order.date}
       - Items: #{order.items.join(', ')}"
    end
  end 

  def create_new_order

    order_to_be_created = new_order_info
    order = Order.new
    order.customer_name, order.date, item_id = order_to_be_created
    @order_repository.create(order, item_id)
   
    @terminal.puts 'New order created!'

  end 

  def new_order_info
    @terminal.puts 'Now creating a new order'
    @terminal.puts 'Please enter the customer name'
    customer_name = @terminal.gets.chomp
    @terminal.puts "Please enter the date the order was placed in the format DD-MMM-YYY
     - e.g.: 01-Jan-2022"
    date = @terminal.gets.chomp
    show_all_shop_items
    @terminal.puts "Please select the number of the item you would like to order from the item menu"
    item_id = @terminal.gets.chomp
    [customer_name,date,item_id]
  end

  def run
    @terminal.puts 'Welcome to the shop management program!'
    # loop do
    display_options_menu
    process(@terminal.gets.chomp)
    # end 
    
  end
end

# # Don't worry too much about this if statement. It is basically saying "only
# # run the following code if this is the main file being run, instead of having
# # been required or loaded by another file.
# # If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
# if __FILE__ == $0
#   app = Application.new(
#     'shop_database_test',
#     Kernel,
#     ItemRepository.new,
#     OrderRepository.new
#   )
#   app.run
# end
