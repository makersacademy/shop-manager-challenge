require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the Shop Manager Program"
    @io.puts "What do you want to do?"
    @io.puts "1. List all shop items"
    @io.puts "2. Create a new item"
    @io.puts "3. List all orders"
    @io.puts "4. Create a new order"
    selection = @io.gets.chomp.to_i

  fail "Invalid Input" unless valid?(selection)
    if selection == 1
      @io.puts "Here is the list of all items:"
      @item_repository.all.map do |item|
      puts "#{item.id}. #{item.name} - #{item.unit_price} - #{item.quantity}"
      end
    elsif selection == 2
      @io.puts "What is the item name"
      name = @io.gets.chomp
      @io.puts "What is the unit price for #{name}"
      unit_price = @io.gets.chomp
      @io.puts "What is the quantity for #{name}"
      quantity = @io.gets.chomp
      @item_repository.create(Item.new(name, unit_price, quantity))
      @io.puts "#{name} item has been created"
    elsif selection == 3
      @io.puts "Here is the list of all orders:"
      @order_repository.all.each do |order|
      puts "#{order.id}. #{order.customer_name} - #{order.date}"
      end
    elsif selection == 4
      @io.puts "What is the customer name"
      customer_name = @io.gets.chomp
      @io.puts "What is the date of this order"
      date = @io.gets.chomp
      @order_repository.create(Order.new(customer_name, date))
      @io.puts "Order for #{customer_name} has been created"
    end
  end

  def valid?(input)
    if input.is_a?(Integer) && input == 1 || input == 2 || input == 3 || input == 4
      return true
    end
  end

end


if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end