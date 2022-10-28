require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application

  def initialize(database_name, terminal, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
  # Runs application and loads interface menu
    @terminal.puts "Welcome to Shop Manager!"
    @terminal.puts "Pick an option (input number):"
    @terminal.puts "1 - List items in stock"
    @terminal.puts "2 - Add new item to stock"
    @terminal.puts "3 - List all orders on record"
    @terminal.puts "4 - Add new order to record"
    input = @terminal.gets.chomp

    case input
    when '1'
      result = @item_repository.all
      result.each do |record| 
        @terminal.puts "ITEM: #{record.name} - PRICE: #{record.price} - STOCK: #{record.quantity} units"
      end
    when '2'
      new_item = Item.new
      @terminal.puts "Enter item name to add:"
      item_input = @terminal.gets.chomp.downcase.capitalize
      new_item.name = item_input
      @terminal.puts "Enter price for #{item_input}:"
      price_input = @terminal.gets.chomp
      new_item.price = "$#{price_input}"
      @terminal.puts "Enter stock quantity for #{item_input}:"
      quantity_input = @terminal.gets.chomp
      new_item.quantity = quantity_input
      @terminal.puts "#{new_item.quantity} x #{new_item.name} @ #{new_item.price} added to stock."
    when '3'
      result = @order_repository.all
      result.each do |record|
        @terminal.puts "CUSTOMER NAME: #{record.customer_name} - ORDER DATE: #{record.date}"
      end
    when '4'
      new_order = Order.new
      @terminal.puts "Enter customer name:"
      name_input = @terminal.gets.chomp.downcase.capitalize
      new_order.customer_name = name_input
      @terminal.puts "Enter order date (YYYY-MM-DD):"
      date_input = @terminal.gets.chomp
   


    end
  end

  def list_item_stock
  # Prints list of items in stock
  end

  def list_orders
  # Prints list of orders on record
  end

  def create_item
  # Adds new item to stock
  end

  def create_order
  # Adds new order to record
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