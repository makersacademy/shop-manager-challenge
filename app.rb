require_relative 'lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"

    choice = @io.gets.chomp

    execute(choice)
  end

  def execute(choice)
    if choice == "1"
      @item_repository.all.each do |record|
        @io.puts "##{record.id} #{record.name} - Unit price: £#{record.unit_price} - Quantity: #{record.quantity}"
      end
    elsif choice == "3"
      @order_repository.all.each do |record|
        @io.puts "##{record.id} #{record.customer_name} - Date: #{record.date} - Item: #{@item_repository.find(record.item_id).name}"
      end
    else
      return
    end
  end

end

# Welcome to the shop management program!

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
#  (...)
