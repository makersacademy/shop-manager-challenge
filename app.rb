require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/item'
require_relative './lib/order'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts "\nWhat do you want to do?\n 1 = List all shop items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order\n"
    number = @io.gets.chomp.to_i
    fail "Please choose a valid option"  unless number == 1 || number == 2 || number == 3 || number == 4
    if number == 1
      format_all_items
    elsif number == 2
      create_item
    elsif number == 3
      format_all_orders
    elsif number == 4
      create_order
    end
  end


  def create_item
    @io.puts "Please give a name"
    name = @io.gets.chomp
    @io.puts "Please give a unit price"
    unit_price = @io.gets.chomp
    @io.puts "Please give a quantity"
    quantity = @io.gets.chomp
    @item_repository.create(Item.new(name, unit_price, quantity))
    @io.puts "Item created"
  end

  def create_order
    @io.puts "Please give a customer name"
    customer_name = @io.gets.chomp
    @io.puts "Please give a date in format YYYY-MM-DD HH:MM:SS"
    date = @io.gets.chomp
    @io.puts "Please give an item id"
    item_id = @io.gets.chomp
    @order_repository.create(Order.new(customer_name, date, item_id))
    @io.puts "Order created"
  end

  def format_all_items
    @io.puts "\nHere is the list of all shop items:"
    @item_repository.all.map do |record|
      puts "\n##{record.id} - #{record.name} - #{record.unit_price} - #{record.quantity}\n"
    end
  end

  def format_all_orders
    @io.puts "\nHere is the list of all shop orders:"
    @order_repository.all.each do |record|
      puts "\n##{record.id} - #{record.customer_name} - #{record.date} - #{record.item_id}\n"
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