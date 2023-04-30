require_relative "./item_repository"
require_relative "./order_repository"
require_relative "./database_connection"

class Application
  def initialize(
    database_name,
    io = Kernel,
    item_repository = ItemRepository.new,
    order_repository = OrderRepository.new
  )
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome_options
    choice = @io.gets.chomp
    process_user_input(choice)
  end
  
  private
  
  def process_user_input(choice)
    case choice
    when "1"
      print_all_items
    when "2"
      add_new_item
    when "3"
      print_all_orders
    when "4"
      add_new_order
    end
  end
    
  def add_new_order
    customer, date = new_order_from_user
    add_order_to_database(customer, date)
  end

  def new_order_from_user
    @io.print "What's the customer name of the new order: "
    customer = @io.gets.chomp
    @io.print "What's the date this order was placed: "
    date = @io.gets.chomp
    [customer, date]
  end

  def add_order_to_database(customer, date)
    order = Order.new
    order.customer_name = customer
    order.date_placed = date
    @order_repository.create(order)
  end

  def add_new_item
    name, price, quantity = new_item_from_user
    add_item_to_database(name, price, quantity)
  end
  
  def new_item_from_user
    @io.print "What's the name of the new item: "
    name = @io.gets.chomp
    @io.print "What's the unit price of the new item: "
    price = @io.gets.chomp
    @io.print "What's the quantity of the new item: "
    quantity = @io.gets.chomp
    [name, price, quantity]
  end
  
  def add_item_to_database(name, price, quantity)
    item = Item.new
    item.name = name
    item.unit_price = price
    item.quantity = quantity
    @item_repository.create(item)
  end
  
  def print_all_items
    items = @item_repository.all
    @io.puts("Here's a list of all shop items:\n")
    items.each_with_index do |item, i|
      formatted_price = format_price(item.unit_price)
      formatted_item = "##{i + 1} #{item.name} - " +
        "Unit price: #{formatted_price} - " +
        "Quantity: #{item.quantity}"
      @io.puts formatted_item
    end
  end
    
  def format_price(price)
    price = price.to_i
    pounds = (price / 100).to_s
    pence = (price % 100).to_s
    pence = "0" + pence if pence.length == 1
    "£#{pounds}.#{pence % 100}"
  end

  def print_all_orders
    orders = @order_repository.all_with_items
    @io.puts "Here's a list of all orders:\n"
    orders.each_with_index do |order, i|
      @io.puts "##{i + 1} Customer: #{order.customer_name} - Date placed: #{order.date_placed}"
      order.items.each_with_index do |item, i|
        @io.puts "    ##{i + 1} #{item.name} - Unit price: #{format_price(item.unit_price)}"
      end
      @io.puts ""
    end
  end
  
  def print_welcome_options
    @io.puts("Welcome to the shop management program!\n")
    @io.puts("What do you want to do?")
    @io.puts("  1 = list all shop items")
    @io.puts("  2 = create a new item")
    @io.puts("  3 = list all orders")
    @io.puts("  4 = create a new order")
    @io.puts("")
  end
end
