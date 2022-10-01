# file: app.rb

require_relative 'lib/database_connection'
require_relative './lib/item_repo'
require_relative './lib/order_repo'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts "\n"
    @io.puts 'What do you want to do?'
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all orders'
    @io.puts '4 = create a new order'
    input = @io.gets.chomp
    case input
      when '1'
        # list('items')
      when '2'
      
      when '3'
        # list('orders')
      when '4'

      end
  end

  def list(table)
    if table == "items"
      repo = ItemRepository.new
      items = repo.all
      @io.puts "Here's a list of all shop items:"
      @io.puts "\n"
      items.each do |item| 
        @io.puts "##{item.id} #{item.item_name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
      end
    elsif table == "orders"
      repo = OrderRepository.new
      orders = repo.all
      @io.puts 'Current unfulfilled orders'
      @io.puts "\n"
      orders.each do |order|
        @io.puts "##{order.id} #{order.customer_name} - order placed: #{order.date}"
      end
    end
  end

  def create(record)
    if record == 'item'
      @io.puts 'Please enter name of new item'
      i_name = @io.gets 'irn bru'
      @io.puts 'Please enter unit price'
      i_price = @io.gets '1'
      @io.puts 'Please enter quantity'
      i_quantity = @io.gets '10'
      @io.puts 'Please enter order number'
      i_order = @io.gets '1'
      @io.puts 'irn bru - Unit price: 1 - Quantity: 10 - added to items'
      item = Item.new
      item.item_name = i_name
      item.price = i_price
      item.quantity = i_quantity
      item.order_id = i_order
      repo = ItemRepository.new
      repo.create(item)
    elsif record == 'order'

    end
  end


# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
  if __FILE__ == $0
    app = Application.new(
      'shop_manager_test',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end

end