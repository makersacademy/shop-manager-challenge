require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/shop_item_repository'

class Application
  def initialize(database, io, order_repository, shop_item_repository)
    DatabaseConnection.connect(database)
    @io = io 
    @order_repository = order_repository
    @shop_item_repository = shop_item_repository
  end

  def run 
    print_menu
    process_choice(@io.gets.chomp)
  end

  private 

  def print_menu
    @io.puts "\nWelcome to the shop management program!"
    @io.puts "\nWhat would you like to do?"
    @io.puts '  1 - list all shop items'
    @io.puts '  2 - create a new item'
    @io.puts '  3 - list all orders'
    @io.puts '  4 - create a new order'
    @io.puts "\nEnter you choice:"
  end

  def process_choice(choice)
    case choice 
    when '1' then print_all_shop_items
    when '2' then create_new_item
    end
  end

  def print_all_shop_items
    @io.puts "\nHere is your list of shop items:"
    @shop_item_repository.all.each do |item|
      @io.puts "##{item.id} - #{item.name} - Unit Price - #{item.unit_price} - Quantity - #{item.quantity}"
    end
  end

  def create_new_item

  end
end

application = Application.new('shop_challenge', Kernel, OrderRepository.new, ShopItemRepository.new)
application.run