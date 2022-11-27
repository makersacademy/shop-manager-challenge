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
    @order_repository.all.each do |order|
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
    order.items_in_order.each do |item|
      items << item.name
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
      item = @shop_item_repository.create_item_object(answer)
      @order_repository.add_item_to_new_order(new_order, item) 
    end
  end
end

# app = Application.new('shop_challenge', Kernel, OrderRepository.new, ShopItemRepository.new)
# app.run