require_relative './lib/item_repository'
require_relative './lib/order_repository'
require 'date'

class Application

  attr_reader :menu_string

  def initialize(io = Kernel, date_class = Date)
    @io = io
    @date_class = date_class
    @methods = [method(:list_all_shop_items), method(:create_an_item), method(:list_all_orders),
                method(:create_an_order), method(:add_item_to_order)]
    @menu_string = build_menu_string
  end

  def run
    # Will loop through the main menu after every completed command
    # until user_input returns 'quit' for main menu input
    result = nil
    while result != 'quit'
      result = user_input
    end
  end

  def user_input
    # Calls a relevant method from @methods based on user input,
    # or returns 'quit' if user entered quit
    input = obtain_user_input
    return input == 'quit' ? 'quit' : @methods[input - 1].call
  end

  def list_all_shop_items
    # Lists all items in the database
    items = ItemRepository.new.list
    for item in items do
      @io.puts "Id: #{item.id} - Item: #{item.name} - £#{item.unit_price} - Qty: #{item.quantity}"
    end
  end

  def create_an_item
    # adds an item to the database with provided name, price and quantity
    # displays the item that has been added to the table
    item = Item.new(obtain_name, obtain_price, obtain_quantity)

    id = ItemRepository.new.create(item)

    @io.puts "Id: #{id} - Item: #{item.name} - £#{item.unit_price} - Qty: #{item.quantity} added"
  end

  def list_all_orders
    # lists all orders in the orders table
    orders = OrderRepository.new.list
    for order in orders do
      @io.puts "Id: #{order.id} - Customer: #{order.customer_name} - Order date: #{order.date}"
    end
  end

  def create_an_order
    # adds an order with the customers name and todays date to the table
    # displays the created order
    @io.puts "Please enter the customer name:"
    name = @io.gets.chomp
    date = @date_class.today.to_s

    order = Order.new(name, date)

    id = OrderRepository.new.create(order)
    @io.puts "Id: #{id} - Customer: #{name} - Order date: #{date} added"
  end

  def add_item_to_order
    # assings an item to a given order based on provided item and order ids
    # displays a confirmation of both
    order_id = obtain_order_id
    item_id = obtain_item_id

    order_repo = OrderRepository.new
    item_repo = ItemRepository.new

    order_repo.assign_item(order_id, item_id)

    item = item_repo.find_by_id(item_id)
    order = order_repo.find_by_id(item_id)
    @io.puts "#{item.name} have been added to #{order.customer_name}'s order"
  end

  private 
  
  def build_menu_string
    string = "What would you like to do?\n\t1 -> List all shop items\n\t2 -> Create a new item\n"
    string << "\t3 -> List all orders\n\t4 -> Create a new order \n\t5 -> Add items to order"
  end

  def obtain_user_input
    # method will recursively loop until user enters either 'quit'
    # or an integer between 1 and highest menu item, upon which it will return those values
    @io.puts @menu_string
    input = @io.gets.chomp
    return input.downcase if input.downcase == 'quit'
    return input.to_i if input.match?(/^\d+$/) && input.to_i.between?(1,@methods.size)
    @io.puts "Please choose one of the valid options or type 'quit' to close the application"
    obtain_user_input
  end

  def obtain_name
    # returns given string, no invalid input checks
    @io.puts "Please enter the name of the item to add:"
    name = @io.gets.chomp
    return name
  end

  def obtain_price
    # will recursively loop until an integer value is given and then returned
    @io.puts "Please enter the price of the item:"
    price = @io.gets.chomp
    return price.to_i if price.match?(/^\d+$/)
    @io.puts "Please enter a valid price for an item"
    obtain_price
  end

  def obtain_quantity
    # will recursively loop until an integer value is given and then returned
    @io.puts "Please enter the quantity of the item:"
    quantity = @io.gets.chomp
    return quantity.to_i if quantity.match?(/^\d+$/) && quantity.to_i >= 0
    @io.puts "Please enter a valid quantity for an item"
    obtain_quantity
  end

  def obtain_order_id
    # will recursively loop until an integer id that is present in orders table is given
    # returns an integer
    @io.puts "Please enter the order id:"
    id = @io.gets.chomp

    return id.to_i if id.match?(/^\d+$/) && OrderRepository.new.check_if_valid_id(id.to_i)
      
    @io.puts "This order id is invalid. Please try again"
    obtain_order_id
  end

  def obtain_item_id
    # will recursively loop until an integer id that is present in items table is given
    # returns an integer
    @io.puts "Please enter the item id:"
    id = @io.gets.chomp

    return id.to_i if id.match?(/^\d+$/) && ItemRepository.new.check_if_valid_id(id.to_i)
    
    @io.puts "This item id is invalid. Please try again"
    obtain_item_id
  end
end

if __FILE__ == $0
  DatabaseConnection.connect('stock_control')
  app = Application.new(Kernel)
  app.run
end
