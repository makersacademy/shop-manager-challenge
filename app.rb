require_relative 'lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

# Could refactor run method so the logic for each step is pulled out into separate methods

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    action_list = "1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n5 = quit program\n\n"
    action = nil
    @io.puts "\nWelcome to the shop management program!\n"

    until action == "exit"
      @io.puts "\nWhat do you want to do?\n#{action_list}"
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
            @io.puts "\n#{order.id}. customer name: #{order.customer} - order date: #{order.date}\nOrder contents:\n"
            items = @item_repository.find_by_order(order.id)
            items.each do |item|
              @io.puts "#{item.name} - unit price: #{item.price}\n"
            end
          end

        when "4"
          order = Order.new
          @io.puts "What is the customer's name?"
          order.customer = @io.gets.chomp
          @io.puts "What date was the order made?"
          order.date = @io.gets.chomp
          @order_repository.create(order)
          last_id = @order_repository.all.last.id
          @created_order = @order_repository.find(last_id)
          @io.puts "How many items do you want to add to the order?"
          number = @io.gets.chomp.to_i
          number.times() do
            @io.puts "What is the id of the item you want to add?"
            item_id = @io.gets.chomp
            item = @item_repository.find(item_id)
            if item.quantity == '0'
              @io.puts "That item is out of stock. Item could not be added. Please start again."
              @order_repository.delete(@created_order.id)
            else
              @created_order.add_item(item)
              item.quantity = item.quantity.to_i - 1
              @item_repository.update(item)
              @io.puts "#{item.name} added to order."
            end
          end

        when "5"
          break

        else
        @io.puts "Invalid input. Please input a number from 1 to 5."
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
