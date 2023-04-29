require_relative 'item_repository.rb'
require_relative 'order_repository.rb'

class Application

  def initialize(database_name = 'shop_manager', io = Kernel, item_repository = ItemRepository.new, order_repository = OrderRepository.new)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome
    ask_for_input
    print_menu
    process(@io.gets.chomp)
  end

  private 

  def print_welcome
    @io.puts 'Welcome to the shop management program!'
  end

  def ask_for_input
    @io.puts "\nWhat do you want to do?"
  end

  def print_menu
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all order'
    @io.puts '4 = create a new order'
    @io.puts '5 = assign an item to an order'
    @io.puts '6 = exit'
  end

  def process(input)
    case input
    when '1'
      #...
    when '2'
      #...
    when '3'
      #...
    when '4'
      #...
    when '5'
      #...
    when '6'
      #...
    end
  end

end