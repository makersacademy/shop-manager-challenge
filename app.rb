require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require 'date'

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
    
    @terminal.puts 'What would you like to do?'
    @terminal.puts '1 - list all shop items'
    @terminal.puts '2 - create a new item'
    @terminal.puts '3 - list all orders'
    @terminal.puts '4 - create a new order'
    @terminal.puts '5 - exit'
    @terminal.puts 'Enter your choice:'


  end 

  def process(menu_selection)
    
    case menu_selection
      when "1"
        show_all_shop_items
      when "2"
        create_new_item
      when "3"
        show_all_shop_orders
      when "5"
        @terminal.puts 'Goodbye!'
        exit 
      else
        puts "Input not recognised, please try again"
      end
  end
 
  def show_all_shop_items

    @terminal.puts 'Here are all currently stored shop items'

    all_shop_items = @item_repository.all
    
    all_shop_items.each do | item |
      @terminal.puts "#{item.id} - Name: #{item.name} - Unit Price: £#{item.unit_price} - Quantity: #{item.quantity}"
    end

  end 

  def create_new_item
    item_to_be_created = get_new_item_info
    item = Item.new
    item.name, item.unit_price, iunit_price = item_to_be_created
    @item_repository.create(item)
    all_shop_items = @item_repository.all

    new_item = all_shop_items.last

    @terminal.puts 'New item created!'
  end 

  def get_new_item_info
    @terminal.puts 'Please enter item name'
    name = @terminal.gets.chomp
    @terminal.puts "Now enter unit price in as a 3 digit number in the format '£.pp' - e.g. 2.35"
    unit_price =  @terminal.gets.chomp
    @terminal.puts "Please enter current stock as a number"
    quantity = @terminal.gets.chomp
    [name,unit_price,quantity]
  end

  def show_all_shop_orders
    @terminal.puts 'Here are all currently stored shop orders'

    all_shop_orders = @order_repository.all
    
    all_shop_orders.each do | order |
      @terminal.puts "#{order.id} - Customer name: #{order.customer_name} - Date: #{order.date} - Items: #{order.items.join(', ')}"
    end
  end 

  def run
    @terminal.puts 'Welcome to the shop management program!'
    
      display_options_menu
      process(@terminal.gets.chomp)
   
    
  end
end

# # Don't worry too much about this if statement. It is basically saying "only
# # run the following code if this is the main file being run, instead of having
# # been required or loaded by another file.
# # If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_database_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
