require_relative 'lib/database_connection'
require_relative 'lib/order_repository'
require_relative 'lib/shop_item_repository'

class Application
  def initialize(database, io, order_repository, shop_item_repository)
    DatabaseConnection.connect(database)
    @io = io 
    @order_repository = order_repository
    @shop_item_repository = shop_item_repository
  end

  def run 
    @io.puts "\nWelcome to the shop management program!"
    loop do 
      print_menu
      case @io.gets.chomp 
      when '1' then print_all_shop_items
      when '2' then create_new_item
      when '3' then print_all_orders
      when '4' then create_new_order
      when '9' then break
      else 
        @io.puts "\nInvalid Input\n"
      end
    end  
  end

  private 

  def print_menu
    @io.puts "\nWhat would you like to do?"
    @io.puts '  1 - list all shop items'
    @io.puts '  2 - create a new item'
    @io.puts '  3 - list all orders'
    @io.puts '  4 - create a new order'
    @io.puts '  9 - exit program'
    @io.puts "\nEnter you choice:"
  end

  def print_all_shop_items
    @io.puts "\nHere is your list of shop items:"
    @shop_item_repository.all.each do |item|
      @io.puts "##{item.id} - #{item.name} - Unit Price - #{item.unit_price} - Quantity - #{item.quantity}"
    end
  end

  def create_new_item
    @io.puts "\n Enter the name of the item:"
    name = @io.gets.chomp 
    @io.puts "\n Enter the unit price of the item (format => 00.00):"
    unit_price = @io.gets.chomp.to_f
    @io.puts "\n Enter the quantity of stock:"
    quantity = @io.gets.chomp.to_i

    new_item = ShopItem.new 
    new_item.name = name 
    new_item.unit_price = sprintf("%.2f", unit_price)
    new_item.quantity = quantity

    @shop_item_repository.create(new_item)
  end

  def print_all_orders
    @io.puts "\nHere is a list of your orders:"
    # section below rejects any orders that never had items associated with them
    valid_orders = @order_repository.all.reject { |order| order.items_in_order.empty? }
    
    valid_orders.each do |order|
      @io.puts "##{order.id} - Customer - #{order.customer_name} - Date Placed - #{order.date_placed} - Items in order - #{show_items_in_order(order)}"
    end
  end

  def create_new_order
    customer_info = get_customer_info
    new_order = Order.new 
    new_order.customer_name, new_order.date_placed = customer_info
    @order_repository.create(new_order)
    new_order.id = @order_repository.all.last.id
    enter_items_in_new_order(new_order)
  end

  def show_items_in_order(order)
    items = []
    order.items_in_order.each do |item, quantity|
      items << "#{item.name} x#{quantity}"
    end
    return items.join(', ')
  end

  def get_customer_info
    @io.puts "\n Enter the name of the customer that placed the order:"
    name = @io.gets.chomp 
    @io.puts "\n Enter the date that order was placed (format => YYYY-MM-DD):"
    date = @io.gets.chomp 
    return [name, date]
  end

  def enter_items_in_new_order(new_order)
    loop do
      @io.puts 'What items were added to this order? Enter "done" when you are done'
      answer = @io.gets.chomp
      break if answer == 'done'
      @io.puts 'What was the quantity of this item added to the order?'
      quantity = @io.gets.chomp.to_i
      item = @shop_item_repository.create_item_object(answer)
      @order_repository.add_item_to_new_order(new_order, item, quantity) 
    end
  end
end

# app = Application.new('shop_challenge_test', Kernel, OrderRepository.new, ShopItemRepository.new)
# app.run

# Functionality:

# - Can view all shop items - see each id, name, price, quantity 
# - Can create a new shop item - shop manager gets to input the name, price and quantity 
# - Can view all orders - see each id, customer name, date order was placed and 
# all of the items that are in each order, this will only show valid orders - i.e.
# orders with items in them.
# - Can create new orders - shop manager can input the name of the customer and the date
# it was placed, then the shop manager can add the items to the order and the 
# quantity of that item added to the order (third column in joins table handles this)
# If the item is out of stock or not in the database then errors are raised. 
# If the item is successfully added to the order then a record is put in the joins table 
# to associate that order with that item and also the stock of the item goes down 
# by the number of items added to that order, so if 10 bananas in stock and 4 were 
# added to the order, the quantity number for bananas in the db would decrease to 6. 
# An error would be raised if you inputted 11 or more as you cant add more to an order than is in stock.

# Things missing / to change:

# - Haven't rspec tested the raising of the error if item is out of stock or when
# not enough stock to fulfil order, although both work - will speak to coaches
# about rspec testing user inputs that would raise an error
