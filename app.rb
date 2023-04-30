require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require 'date'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @break = false
  end

  def run
    
    # until @break == true do
      @io.puts "Welcome to the shop management program!"
      @io.puts "What do you want to do?"
      @io.puts "  1 = list all shop items"
      @io.puts "  2 = create a new item"
      @io.puts "  3 = list all orders"
      @io.puts "  4 = create a new order"

      choice = @io.gets.chomp

      execute(choice)
    # end
  end

  def execute(choice)
    if choice == "1"
      @item_repository.all.each do |record|
        @io.puts "##{record.id} #{record.name} - Unit price: £#{record.unit_price} - Quantity: #{record.quantity}"
      end
    elsif choice == "2"
      new_item = Item.new

      @io.puts "Please enter the item's name"
      new_item.name = @io.gets.chomp
      @io.puts "Please enter the item's unit price"
      new_item.unit_price = @io.gets.chomp
      @io.puts "Please enter the item's quantity"
      new_item.quantity = @io.gets.chomp

      @item_repository.create(new_item)

      @io.puts "Item #{new_item.name} successfully added to the shop!" 
    elsif choice == "3"
      @order_repository.all.each do |record|
        @io.puts "##{record.id} #{record.customer_name} - Date: #{record.date} - Item: #{@item_repository.find(record.item_id).name}"
      end
    elsif choice == "4"
      new_order = Order.new

      @io.puts "Please enter the customer's name"
      new_order.customer_name = @io.gets.chomp
      new_order.date = Date.today
      @io.puts "Please enter the item they'd like to order"
      item_input = @io.gets.chomp
      
      @item_repository.all.each do |item|
        if item.name == item_input
          new_order.item_id = item.id
        end
      end

      @order_repository.create(new_order)

      @io.puts "Order successfully created for #{new_order.customer_name} today!"
    else
      # @break = true
    end
  end

end

# item_repository = ItemRepository.new
# order_repository = OrderRepository.new
# io = Kernel
# app = Application.new('shop_manager', io, item_repository, order_repository)
# app.run

# uncomment all comments to run the Application class with a loop and using shop_manager production database