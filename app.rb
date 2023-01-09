require_relative './lib/item_repository'    
require_relative './lib/order_repository'

class Application

  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat do you want to do?"
    @io.puts "1 = list all shop items\n2 = create a new item"
    @io.puts "3 = list all orders\n4 = create a new order"
    @io.puts "Enter your choice:"
    user_input = @io.gets.chomp
    if user_input == "1"
      @io.puts "Here is the list of items:"
      @item_repository.all.each do |entry|
      @io.puts "* #{entry.id} - #{entry.item_name} - Unit price: #{entry.unit_price} - Quantity: #{entry.quantity}"
      end
    end
  end

end


# end
    

# Welcome to the shop management program!

    # What do you want to do?
    #   1 = list all shop items
    #   2 = create a new item
    #   3 = list all orders
    #   4 = create a new order

    # 1 [enter]

    # Here's a list of all shop items:

    # #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
    # #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
    # (...)

