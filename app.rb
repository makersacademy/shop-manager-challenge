require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'


class Application
  def initialize(database_name, io, item_repository, order_repository, item_class, order_class)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @item_class = item_class
    @order_class = order_class
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    choice = get_user_choice
    case choice
    when "1"
      display_items
    when "2"
      create_item
    end
  end

  private

  def get_user_choice
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    choice = @io.gets.chomp
    @io.puts ""
    return choice
  end

  def display_items
    @io.puts "Here's a list of all shop items:"
    @io.puts ""
    @item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_item
    item = @item_class.new
    @io.puts "Item name:"
    item.name = @io.gets.chomp
    @io.puts "Item price:"
    item.unit_price = @io.gets.chomp.to_f
    @io.puts "Item quantity:"
    item.quantity = @io.gets.chomp.to_i
    @item_repository.create(item)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
  