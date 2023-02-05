require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application

# Perform a SQL query on the database and get the result set.
  def initialize(shop_manager_test, terminal, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager')
    @terminal = terminal
    @item_repository = item_repository
    @order_repository = order_repository
    @input = ""
  end

  def welcome_message
    @terminal.puts "Welcome to the shop management program!"
    @terminal.puts "What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    @input = @terminal.gets.chomp
    @input = @input.to_i
  end

  def run
    if @input == 1
      list_items
    elsif @input == 2
      create_item
    elsif @input == 3
      list_orders
    elsif @input == 4
      create_order
    end
  end

  def list_items 
    @terminal.puts "Here is the list of items:"
    items = @item_repository.all  
    items.each do |record|
      @terminal.puts "ID: #{record.id}, #{record.name}, Price: #{record.price}, Quantity: #{record.quantity}"
    end
  end 

  def create_item
    new_item = Item.new

  @terminal.puts "Enter item ID"
    new_item.id = @terminal.gets.chomp.to_i
    @terminal.puts "Enter the name of item"
    new_item.name = @terminal.gets.chomp
    @terminal.puts "Enter the price of the item(in a whole number)"
    new_item.price =  @terminal.gets.chomp.to_i
    @terminal.puts "Enter item quantity"
    new_item.quantity = @terminal.gets.chomp.to_i
  
    @item_repository.create(new_item)
    @terminal.puts "New item added"
  end  

  def list_orders
    @terminal.puts "Here is the list of orders:"
    orders = @order_repository.all  
    orders.each do |record|
      @terminal.puts "* #{record.customer_name} ID: #{record.id} Item ID: #{record.item_id}"
    end
  end 

  def create_order
  new_order = Order.new
  @terminal.puts "Enter order ID"
  new_order.id = @terminal.gets.chomp.to_i
  @terminal.puts "Enter customer name"
  new_order.customer_name = @terminal.gets.chomp
  @terminal.puts "Enter date of order(yyyy-mm-dd))"
  new_order.date =  @terminal.gets.chomp
  @terminal.puts "Enter item ID"
  new_order.item_id = @terminal.gets.chomp.to_i
  
  @order_repository.create(new_order)
  @terminal.puts "New order added"
  end  

  if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.welcome_message
  app.run
  end
end