require_relative './lib/order_repository'
require_relative './lib/item_repository'

class Application
  
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def ask_user
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
  end

  def print_all_items
    @io.puts "Here's a list of all shop items:"
    @item_repository.all.each do |item|
      @io.puts "#{item.id}. #{item.name} - $#{item.price} - amount: #{item.quantity}"
    end
  end

  def run
    ask_user
    choice = @io.gets.chomp
    case choice
    when "1"
      print_all_items
    when "2"
    when "3"
    when "4"
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
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
