# file: app.rb
require_relative './lib/database_connection'
require_relative './lib/order_repository'
require_relative './lib/item_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(shop_manager, io, order_repository, item_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What do you want to do?'
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all orders'
    @io.puts '4 = create a new order'


    @io.puts 'Enter your choice: '
    choice = @io.gets.to_i

    if choice == 1

      @item_repository.all.each do |item|
          p "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
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
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end