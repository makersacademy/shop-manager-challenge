require_relative './lib/item_repository.rb'
require_relative './lib/order_repository.rb'
require_relative './lib/item.rb'
require_relative './lib/order.rb'
require_relative './lib/database_connection.rb'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    while true
      @io.puts "What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order
  5 = exit"

      action = @io.gets.chomp
      if action == "1"
        repo = ItemRepository.new
        @io.puts "Here's a list of shop items: #{repo.all}"
      elsif action == "2"
        @io.puts "Please enter item name:"
        name = @io.gets.chomp
        @io.puts "Please enter item price:"
        price = @io.gets.chomp
        @io.puts "Please enter item quantity"
        quantity = @io.gets.chomp
        repo = ItemRepository.new
        new_item = Item.new
        new_item.name = name
        new_item.price = price
        new_item.quantity = quantity
        repo.create(new_item)
      elsif action == "5"
        break
      end
    end
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