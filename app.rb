# file: app.rb

require_relative './lib/order_repository'
require_relative './lib/item_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the OrderRepository object (or a double of it)
  #  * the ItemRepository object (or a double of it)
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    show "Welcome to the shop management program!\n"
    while true
      input = obtain_selection
      case input
      when "1"
        show "Here is the list of all shop items\n"
        print_items
      when "2"
        show "Here is the list of all shop orders\n"
        print_orders
      else
        break
      end
    end
    
  end

  private

  def show(message)
    @io.puts message
  end

  def obtain_selection
    show "\nWhat do you want to do?\n" \
      "  1 = list all shop items\n" \
      "  2 = create a new item\n" \
      "  3 = list all orders\n" \
      "  4 = create a new order\n" \
      "  5 = end the program"
    @io.gets.chomp
  end

  def print_items
    @item_repository.all.each do |item|
      show "##{item.id} #{item.name} - Unit Price: £#{item.unit_price}"
    end
  end

  def print_orders
    @order_repository.all.each do |order|
      show "#{order.customer_name} ordered on #{order.date}"
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
