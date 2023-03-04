# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/item'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the OrderRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop managment program!"
    loop do
    @io.puts "What do you want to do?  
  1 = List all shop items  
  2 = Create a new item  
  3 = List all orders  
  4 = Create a new order"
    input = @io.gets.chomp
    break if input.empty?
    input_cases(input)
    end
  end

  def input_cases(input)
    case input
    when "1"
      @io.puts format_items_list
    when "2"
      create_new_item
    when "3"

    when "4"
    end
  end

  def format_items_list
    items = @item_repository.all
    format_string_array = []
    items.each_with_index do |item, index|
      str = "#{index + 1} - #{item.name} - Price: #{item.price} - Quantity: #{item.quantity}"
      format_string_array << str
    end
    format_string_array
  end

  def create_new_item
    item = Item.new
    @io.puts "Please enter the item name:"
    item.name = @io.gets.chomp
    @io.puts "Please enter the item's price:"
    item.price = @io.gets.chomp
    @io.puts "Please enter the item quantity:"
    item.quantity = @io.gets.chomp
    @item_repository.create(item)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
