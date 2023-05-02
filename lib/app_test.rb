require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'order_repository'

class Application

  def initialize(database_name, io = Kernel, item_repository = ItemRepository.new, order_repository = OrderRepository.new)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    list_choices
    choice = @io.gets.chomp
    case choice
    when '1'
      @item_repository.all.each_with_index do |item, i|
        @io.puts "* #{i+1} - #{item.name}"
      end
    when '2'
      # create a new item
    when '3'
      # list all orders
    when '4'
      # create a new order
    end
    
  end

  private

  def list_choices
    @io.puts "\nWhat do you like to do?"
    @io.puts '1 - List all shop items'
    @io.puts '2 - Create a new item'
    @io.puts '3 - List all orders'
    @io.puts '4 - Create a new order'
    @io.print 'Enter your choice: '
  end

end

if __FILE__ == $0
  app = Application.new(
    'items_orders_test',
    Kernel,
    ItemRepository.new,
    'OrderRepository.new'
  )
  app.run
end