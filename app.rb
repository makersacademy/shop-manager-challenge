require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, order_repository, item_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @order_repository = order_repository
        @item_repository = item_repository
        # binding.irb
    end

    def print_program_menu
        @io.puts 'Welcome to the shop manager!'
        @io.puts ''
        @io.puts 'What do you want to do?'
        @io.puts '  1 = List all shop items'
        @io.puts '  2 = Create a new item'
        @io.puts '  3 = List all orders'
        @io.puts '  4 = Create a new order'
        @io.puts '  9 = Exit'
    end

    def shop_manager_program
        code = @io.gets.to_i
        # binding.irb
        case code
        when 1
            list_all_shop_items
        when 2
            create_a_new_item
        when 3
            list_all_orders
        when 4
            create_a_new_order
        when 9
            exit
        else
        @io.puts "I don't know what you meant, try again"
        end
    end

    def list_all_shop_items
        all_items = @item_repository.all
        all_items.each do | data |
            @io.puts "#{data.id} - #{data.name}: #{data.price}: #{data.quantity}"
        end
    end

    def create_a_new_item
        created_item = Item.new 
        @io.puts 'Enter name of item: '
        created_item.name = @io.gets.chomp
        @io.puts 'Enter price of item: '
        created_item.price = @io.gets.chomp
        @io.puts 'Enter quantity of item: '
        created_item.quantity = @io.gets.chomp
        # binding.irb

        @item_repository.create(created_item)
    end

    def list_all_orders
        all_orders = @order_repository.all
        all_orders.each do | data |
            @io.puts "#{data.id} - #{data.customer}: #{data.date}: #{data.order_id}"
        end
    end

    def create_a_new_order
        created_order = Order.new 
        @io.puts 'Enter customer order name: '
        created_order.customer = @io.gets.chomp
        @io.puts 'Enter order date (YYYY-MM-DD): '
        created_order.date = @io.gets.chomp
        @io.puts 'Enter order_id of item: '
        created_order.order_id = @io.gets.chomp
        # binding.irb

        @order_repository.create(created_order)
    end

    def run
        loop do
            print_program
            shop_manager_program
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
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end