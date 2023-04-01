require_relative 'lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager')
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    action_list = "1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n"
    action = nil

    until action == "exit"
      @io.puts "\nWelcome to the shop management program!\n\nWhat do you want to do?\n#{action_list}"
      action = @io.gets.chomp

      case action
        when "1"
          items = @item_repository.all
          items.each do |item|
            @io.puts "\n#{item.id}. #{item.name} - unit price: #{item.price} - quantity: #{item.quantity}"
          end

        when "2"
          item = Item.new
          @io.puts "What is the name of the item?"
          item.name = @io.gets.chomp
          @io.puts "What is the price of the item?"
          item.price = @io.gets.chomp
          @io.puts "How many of the item will be in stock?"
          item.quantity = @io.gets.chomp

          @item_repository.create(item)

          @io.puts "#{item.name} added to the database."

        when "3"
          orders = @order_repository.all
          orders.each do |order|
            @io.puts "\n#{order.id}. customer name: #{order.customer} - order date: #{order.date}"
          end

        when "4"

        when "exit"
          break

        else
        @io.puts "Invalid input. Please input a number from 1 to 4, or exit to quit the program."
      end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new)
    app.run
end
