require_relative "./lib/database_connection.rb"
require_relative "./lib/item_repository.rb"
require_relative "./lib/order_repository.rb"
require_relative "./lib/item.rb"
require_relative "./lib/order.rb"
require 'date'
require 'colorize'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome
    loop do
      print_interface
      user_selection(@io.gets.chomp)
    end
  end

  def print_welcome
    @io.puts "\n"
    @io.puts "Welcome to the shop management program!".colorize(:blue)
  end

  def print_interface
    @io.puts "\n"
    @io.puts "Please select one of the options:".colorize(:blue)
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "5 = exit program"
    @io.puts "\n"
  end

  def user_selection(input)
    @io.puts "You selected option #{input}.".colorize(:blue)
    @io.puts "\n"
    case input
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order
    when "5"
      exit
    else 
      @io.puts "Invalid! Please enter valid option.".colorize(:red)
    end
  end

  def list_items
    @io.puts "ITEMS IN STOCK:".colorize(:blue)
    @io.puts "\n"
    items = @item_repository.all
    items.each { |record|
      @io.puts "##{record.id} #{record.name} - Unit price: #{record.price} - Quantity: #{record.quantity}"
    }
  end

  def create_item
    item = Item.new
    item.name = get_item_name
    item.price = get_price
    item.quantity = get_quantity
    
    @item_repository.create(item)
    @io.puts "#{item.name} was added in stock.".colorize(:green)
  end

  def list_orders
    @io.puts "CURRENT ORDERS:".colorize(:blue)
    @io.puts "\n"
    
    get_id_list.each { |order_id|
      order = @order_repository.find_by_order(order_id)
      @io.puts "##{order.id} #{order.customer_name} - Order date: #{order.order_date} - Items:"
      order.items.each { |item|
        @io.puts "- ##{item.id} #{item.name} - Price: #{item.price}"
      }
      @io.puts "\n"
    }
  end

  def create_order
    order = Order.new
    order.customer_name = get_customer_name
    order.order_date = get_date
    item_id = get_linked_item

    @order_repository.create(order)

    order_id = @order_repository.all.last.id

    @order_repository.link_to_item(order_id, item_id)

    @io.puts "Order for #{order.customer_name} was created.".colorize(:green)

    item = @item_repository.find(item_id)
    
    # Reduces item quantity by 1 after the order is placed.
    reduce_stock(item)
  end

  def reduce_stock(item)
    item.quantity = item.quantity.to_i - 1
    @item_repository.update(item)

    @io.puts "#{item.name} quantity in stock was reduced by one.".colorize(:green)
  end

  private

  def get_id_list
    id_list = []
    @order_repository.all.each { |record| 
      id_list << record.id
    }
    id_list
  end

  def get_item_name
    @io.puts "Enter item name:"
    item_name = @io.gets.chomp 
  end

  def get_price
    @io.puts "Enter item price:"
    item_price = @io.gets.chomp
    
    while item_price.to_f <= 0 # Loops if anything but positive number was entered
      @io.puts "Please enter valid price.".colorize(:red)
      item_price = @io.gets.chomp
    end
  
    item_price.to_f
  end

  def get_quantity
    @io.puts "Enter item quantity:"
    item_quantity = @io.gets.chomp
    
    while (item_quantity.to_i.to_s != item_quantity) || (item_quantity.to_i <= 0)
      @io.puts "Please enter valid quantity.".colorize(:red)
      item_quantity = @io.gets.chomp
    end
    
    item_quantity.to_i
  end

  def get_customer_name
    @io.puts "Enter customer name:"
    customer_name = @io.gets.chomp
  end

  def get_linked_item
    id_list = []
    @item_repository.all.each { |record|
      id_list << record.id
    }

    @io.puts "Enter item ordered:"
    item = @io.gets.chomp

    until id_list.include?(item)
      @io.puts "Please enter valid item in stock.".colorize(:red)
      item = @io.gets.chomp
    end

    item.to_i
  end

  def get_date
    date = Date.today 
    date.strftime "%Y-%m-%d"
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end