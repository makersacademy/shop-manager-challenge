require_relative "./lib/order_repository"
require_relative "./lib/item_repository"
require_relative "./lib/database_connection"

class Application
  def initialize(db_name, io, order_repo, item_repo)
    DatabaseConnection.connect(db_name)
    @io = io
    @order_repo = order_repo
    @item_repo = item_repo
    @options = ["list all shop items", "create a new item", "update an item's price",
                "update stock of an item", "list all orders", "create a new order"]
  end

  # runs the programme
  def run
    @io.puts "Welcome to the shop management program!"
    loop do
      print_options()
      choice()
      break unless continue?()
    end
  end

  private

  # Prints out all options in terminal
  def print_options
    @io.puts ""
    @io.puts "What do you want to do?"
    @options.each_with_index do |option, index|
      @io.puts " #{index + 1} = #{option}"
    end
    @io.puts ""
    @io.puts "Enter your option:"
  end

  # Filter user input by a Regex pattern
  def filter_input(input, pattern)
    return input.chars.select { |char| char[pattern] }.join
  end

  # Asks the user for a choice
  def choice
    choice = filter_input(@io.gets.chomp, /\d+/).to_i
    while choice <= 0 || choice == "" || choice > @options.length
      @io.puts "Invalid input. Please enter again:"
      choice = filter_input(@io.gets.chomp, /\d+/).to_i
    end
    case choice
    when 1
      list_items()
    when 2
      create_item()
    when 3
      update_price()
    when 4
      update_stock()
    when 5
      list_orders()
    when 6
      create_order()
    end
  end

  # Asks the user if they want to continue
  def continue?
    @io.puts ""
    @io.puts "Do you want to continue the programme? (y/n)"
    choice = filter_input(@io.gets.chomp, /y|n/)
    while choice == ""
      @io.puts "Invalid input. Please enter again:"
      choice = filter_input(@io.gets.chomp, /y|n/)
    end
    return choice == "y"
  end

  # prints out list of items on terminal
  def list_items
    @io.puts ""
    @io.puts "Here's a list of all shop items:"
    @io.puts ""
    items = @item_repo.all
    items.each do |item|
      @io.puts " #{item.id}. #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  # prints out list of orders on terminal
  def list_orders
    @io.puts ""
    @io.puts "Here's a list of all orders:"
    @io.puts ""
    orders = @order_repo.all
    orders.each do |order|
      @io.puts "#{order.id}. #{order.date} #{order.customer_name.capitalize}'s Order:"
      @io.puts "  ----------"
      @io.puts "  Items:"
      order.items.each do |item|
        @io.puts "    - #{item[:name].capitalize} - Qty: #{item[:quantity]}"
      end
      @io.puts "  ----------"
      @io.puts "  Grand total: $#{order.total_price}"
      @io.puts "  ----------"
      @io.puts ""
    end
  end

  # creates a new order by calling OrderRepository
  def create_order
    @io.puts ""
    @io.puts "Create a new order"
    @io.puts "----------"
    @io.puts "Please enter the following details:"
    @io.puts ""
    @io.puts "1. What is the customer's name?"
    name = @io.gets.chomp.capitalize
    items = []
    loop do
      @io.puts ""
      @io.puts "----------"
      @io.puts "There is #{items.length} item(s) in #{name}'s order."
      @io.puts "----------"
      @io.puts "Please enter item ID."
      id = @io.gets.chomp.to_i
      @io.puts ""
      @io.puts "Please enter quantity."
      qty = @io.gets.chomp.to_i
      begin
        if @item_repo.enough_stock?(id, qty)
          items << { item_id: id, quantity: qty }
        else
          @io.puts "Sorry, there is no enough stock for this item."
        end
      rescue RuntimeError => e
        @io.puts e.message
      end
      @io.puts ""
      @io.puts "Continue to add items? (y/n)"
      choice = filter_input(@io.gets.chomp, /y|n/)
      while choice == ""
        @io.puts "Invalid input. Please enter again:"
        choice = filter_input(@io.gets.chomp, /y|n/)
      end
      break if choice == "n"
    end
    @order_repo.create_order(name, items, @item_repo)
    @io.puts ""
    @io.puts "----------"
    @io.puts "There is total #{items.length} item(s) in #{name}'s order."
    @io.puts "Order has been successfully created!"
  end

  # creates a new item by calling ItemRepository
  def create_item
    @io.puts ""
    @io.puts "Create a new item"
    @io.puts "----------"
    @io.puts "Please enter the following details:"
    @io.puts ""
    @io.puts "1. Name for this new item:"
    name = filter_input(@io.gets.chomp, /[a-zA-Z ]/).strip
    # Checks if input valid
    while name == ""
      @io.puts "Invalid input. Please enter again."
      name = filter_input(@io.gets.chomp, /[a-zA-Z ]/)
    end
    @io.puts ""
    @io.puts "2. Unit price:"
    price = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while price == ""
      @io.puts "Invalid input. Please enter again."
      price = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "3. How many item in stock?"
    stock = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while stock == ""
      @io.puts "Invalid input. Please enter again."
      stock = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "----------"
    @item_repo.create_item(name, price.to_i, stock.to_i)
    @io.puts "Item has been successfully created!"
  end

  # updates an item's price by calling ItemRepository
  def update_price
    @io.puts ""
    @io.puts "Update an item's price"
    @io.puts "----------"
    @io.puts "Please enter the following details:"
    @io.puts ""
    @io.puts "1. Item's ID:"
    id = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while id == ""
      @io.puts "Invalid input. Please enter again."
      id = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "2. Updated price of this item:"
    updated_price = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while updated_price == ""
      @io.puts "Invalid input. Please enter again."
      updated_price = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "----------"
    @io.puts ""
    begin
      @item_repo.update_price(id.to_i, updated_price.to_i)
    rescue RuntimeError => e
      @io.puts e.message
    else
      @io.puts "Item has been successfully updated!"
    end
  end

  # updates an item's stock by calling ItemRepository
  def update_stock
    @io.puts ""
    @io.puts "Update an item's stock"
    @io.puts "----------"
    @io.puts "Please enter the following details:"
    @io.puts ""
    @io.puts "1. Do you want to add or remove? (+/-)"
    action = filter_input(@io.gets.chomp, /\+|\-/)
    # Checks if input valid
    while action == ""
      @io.puts "Invalid input. Please enter again."
      action = filter_input(@io.gets.chomp, /\+|\-/)
    end
    @io.puts ""
    @io.puts "2. Item's ID:"
    id = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while id == ""
      @io.puts "Invalid input. Please enter again."
      id = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "3. How many do you want to add?"
    qty = filter_input(@io.gets.chomp, /\d+/)
    # Checks if input valid
    while qty == ""
      @io.puts "Invalid input. Please enter again."
      qty = filter_input(@io.gets.chomp, /\d+/)
    end
    @io.puts ""
    @io.puts "----------"
    @io.puts ""
    begin
      @item_repo.update_stock(id.to_i, qty.to_i, action)
    rescue RuntimeError => e
      @io.puts e.message
    else
      @io.puts "Item has been successfully updated!"
    end
  end
end

# The lines below will be executed only while running 'ruby app.rb'
# if __FILE__ == $0
#   app = Application.new(
#     "shop_manager",
#     Kernel,
#     OrderRepository.new,
#     ItemRepository.new
#   )
#   app.run
# end
