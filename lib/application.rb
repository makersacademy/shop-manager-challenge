require_relative "./item_repository"
require_relative "./order_repository"
require_relative "./database_connection"

class Application
  def initialize(
    database = "shop_manager",
    io = Kernel,
    item_repository = ItemRepository.new,
    order_repository = OrderRepository.new
  )
    DatabaseConnection.connect(database)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome_options
    choice = @io.gets.chomp
    case choice
    when "1"
      print_all_items
    when "2"
      get_new_item_from_user
    when "3"
      print_all_orders
    end
  end
  
  private
  
  def get_new_item_from_user
    @io.print "What's the name of the new item: "
    name = @io.gets.chomp
    @io.print "What's the unit price of the new item: "
    price = @io.gets.chomp
    @io.print "What's the quantity of the new item: "
    quantity = @io.gets.chomp
    add_item_to_database(name, price, quantity)
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
      price = item.unit_price.to_i
      formatted_price = "£#{price / 100}.#{price % 100}"
      @io.puts "##{i + 1} #{item.name} - Unit price: #{formatted_price} - Quantity: #{item.quantity}"
    end
  end

  def print_all_orders
    orders = @order_repository.all
    @io.puts "Here's a list of all orders:\n"
    orders.each_with_index do |order, i|
      @io.puts "##{i + 1} Customer: #{order.customer_name} - Date placed: #{order.date_placed}"
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
