require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'item'
require_relative 'order'
require_relative 'order_repository'
require_relative 'format'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
    @format = Format.new
  end
  
  def show_menu(forever = true)
    running = true

    @io.puts @format.header("Welcome to the shop management program!")
    while running do
      @io.puts @format.string("Choose from one of these options:", :cyan, :before)
      @io.puts "  1. List all items"
      @io.puts "  2. Create new item"
      @io.puts "  3. List all orders"
      @io.puts "  4. Create new order"
      @io.puts "  5. Exit"
      input = @io.gets.chomp
      process_selection(input)
      running = forever
    end
  end
  
  def process_selection(input)
    case input
    when "1"
      show_all_items
    when "2"
      create_new_item
    when "5"
      exit # TODO: need to test for exiting
    end
  end
  
  def show_all_items
    @io.puts @format.header("All items")
    items = @item_repository.all
    items.each do |item|
      @io.puts "  #{item.id} - #{item.name} – #{@format.currency(item.price)} (#{item.quantity} in stock)"
    end
    @io.puts "\n"
  end
  
  def create_new_item
    @io.puts @format.header("Add a new item")
    @io.puts @format.string("Enter the item's details", :cyan)
    @io.puts "Item name:"
    name = @io.gets.chomp
    @io.puts "Item price (e.g. 3.25):"
    price = @io.gets.chomp
    @io.puts "Quantity in stock:"
    quantity = @io.gets.chomp
    
    item = Item.new
    item.name = name
    item.price = price
    item.quantity = quantity
    @item_repository.create(item)
    
    @io.puts @format.string("#{name} added to the databse", :green, :pad)
  end
  
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.show_menu
end
