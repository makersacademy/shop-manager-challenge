require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'order_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end
  
  def show_menu(forever = true)
    running = true
    @io.puts "Welcome to the shop management program!\n\n"
    while running do
      @io.puts "Choose from one of these options:"
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
    when "1" # TODO: need to test for printing all items
      # item_repo = @item_repository
      items = @item_repository.all
      items.each do |item|
        @io.puts "#{item.id} - #{item.name} (#{item.quantity} in stock)"
      end
    when "5"
      exit # TODO: need to test for exiting
    end
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
