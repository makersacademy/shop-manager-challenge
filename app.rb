# require_relative 'lib/database_connection'
# require_relative 'lib/artist_repository'
# require_relative 'lib/album_repository'

# DatabaseConnection.connect('music_library')

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#  p artist
# end

# album_repository.all.each do |album|
#   puts "#{album.id} - #{album.title} - #{album.release_year}"
#  end

# # result = DatabaseConnection.exec_params('SELECT * FROM artists;', [])

# # result.each do |record|
# #     p record
# # end

# artist = artist_repository.find(4)
# puts artist.name

# album = album_repository.find(4)
# puts album.title

# file: app.rb

require_relative './lib/order_repository'
require_relative './lib/stock_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(shop_manager, io, stock_repository, order_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @order_repository = order_repository
    @stock_repository = stock_repository
  end

  def options
    @io.puts "Welcome to the shop management program!"
    @io.puts "What would you like to do?"
    @io.puts "1 - list all shop items"
    @io.puts "2 - create a new item"
    @io.puts "3 - list all orders"
    @io.puts "4 - create a new order"
    @io.puts "exit to quit"
    @io.puts "Enter your choice"
  end

  def interactive_menu
    loop do
      options
      input = @io.gets.chomp
      if input == '1' then
        @stock_repository.all.each do |stock|
          @io.puts "# #{stock.id} - Unit price: #{stock.item} - Quantity: #{stock.quantity}"
        end
      elsif input == '3' then
        @order_repository.all.each do |order|
          @io.puts "# #{order.id} - Name: #{order.customer_name} - Date: #{order.order_date}"
        end
      elsif input == '4' then
        new_order
        next
      elsif input == '2' then
        new_stock
        next
      elsif input == 'exit' then
        exit
      else
        puts "wrong argument"
      end
    end
  end

  def run

    interactive_menu
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

  def new_order
    order = Order.new
    @io.puts "enter the client"
    order.customer_name = @io.gets.chomp
    @io.puts 'stock_id'
    order.stock_id = @io.gets.chomp
    @io.puts 'order date'
    order.order_date = @io.gets.chomp
    @order_repository.create(order)
  end

  def new_stock
    stock = Stock.new
    @io.puts "enter the item"
    stock.item = @io.gets.chomp
    @io.puts 'enter unit price'
    stock.unit_price = @io.gets.chomp
    @io.puts 'enter quantity'
    stock.quantity = @io.gets.chomp
    @stock_repository.create(stock)
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
    StockRepository.new,
    OrderRepository.new
  )
  app.run
end