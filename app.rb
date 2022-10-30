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
    print_menu
    input = @terminal.gets.chomp
    case input
    when '1'
      list_item_stock
    when '2'
      create_item
    when '3'
      list_orders
    when '4'
      create_order
    when '5'
      exit
    end
  end

  def list_item_stock
  # Prints list of items in stock
    result = @item_repository.all
    result.each do |record| 
      @terminal.puts "ITEM: #{record.name} - PRICE: #{record.price} - STOCK: #{record.quantity} units"
    end
  end

  def list_orders
  # Prints list of orders on record
    result = @order_repository.all
    result.each do |record|
      @terminal.puts "CUSTOMER NAME: #{record.customer_name} - ORDER DATE: #{record.date}"
    end
  end

  def create_item
  # Adds new item to stock
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
  end

  def create_order
  # Adds new order to record
    new_order = Order.new
    @terminal.puts "Enter customer name:"
    name_input = @terminal.gets.chomp.downcase.capitalize
    new_order.customer_name = name_input
    @terminal.puts "Enter order date (YYYY-MM-DD):"
    date_input = @terminal.gets.chomp
    @order_repository.create(new_order)
    new_order_id = (@order_repository.all.length - 1)
    @terminal.puts "Order record created. Assign items? (Y/N)"
    assign_input = @terminal.gets.chomp.downcase
    while assign_input != 'n'
      if assign_input == 'y'
        @terminal.puts "Enter item ID to add to order:"
        item_input = @terminal.gets.chomp.to_i
        added_item = @item_repository.find(item_input)
        @order_repository.add_items_to_order(new_order_id, added_item.id)
        @terminal.puts "#{added_item.name} added to Order ID: #{new_order_id}."
        @terminal.puts "Add another item? (Y/N)"
        assign_input = @terminal.gets.chomp.downcase
      else
        @terminal.puts "Invalid input. Enter Y or N."
      end
    end
  end
end

def print_menu
  @terminal.puts "Welcome to Shop Manager!"
  @terminal.puts "Pick an option (input number):"
  @terminal.puts "1 - List items in stock"
  @terminal.puts "2 - Add new item to stock"
  @terminal.puts "3 - List all orders on record"
  @terminal.puts "4 - Add new order to record"
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