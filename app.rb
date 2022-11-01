# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/item_repository'
require_relative 'lib/item'

# The Application class initializer
class Application
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
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts "\nWhat do you want to do?"
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all orders'
    @io.puts "4 = create a new order\n"
    input = @io.gets.chomp
    if input == '1'
      @io.puts "\nHere's a list of all shop items:\n"

      results = @item_repository.list
      stock = Hash.new(0)
      price = Hash.new(0)
      results.each do |item|
        if item.order_id.nil?
          stock[item.item_name] += 1
          price[item.item_name] = item.price
        end
      end
      stock.each do |key, total|
        @io.puts "\# #{key} - Unit price: #{price[key]} - Quantity: #{total}"
      end
    end
    if input == '2'
      item = Item.new
      @io.puts 'Enter the item name:'
      item.item_name = @io.gets.chomp
      @io.puts 'Enter the item unit price:'
      item.price = @io.gets.chomp
      @item_repository.create(item)
      @io.puts "\nItem created"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new,
  )
  app.run
end
