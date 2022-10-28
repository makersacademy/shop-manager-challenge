require_relative './lib/database_connection'
require_relative './lib/item_repository'

class Application
  def initialize(database_name, io, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
  end

  def run
    print_header
    interactive_menu
    
  end

  def print_header
    @io.puts 'Welcome to the shop management program!'
  end

  def interactive_menu
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    selection = @io.gets.chomp
    case selection
    when "1" then items
    when "2" then add_item
    end
  end

  def items
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      puts record.values.join(" - ")
    end
  end

  def add_item
    item = Item.new
    @io.puts "Please enter item name"
    item.item_name = @io.gets.chomp
    @io.puts "Please enter item price"
    item.item_price = @io.gets.chomp
    @io.puts "Please enter item quantity"
    item.item_quantity = @io.gets.chomp
    @item_repository.create(item)
    @io.puts 'Item created'
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_challenge_test',
    Kernel,
    ItemRepository.new,
  )
  app.run
end
