require_relative "./lib/order_repository"
require_relative "./lib/item_repository"
require_relative "./lib/database_connection"
require_relative "./lib/order"
require_relative "./lib/item"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"
    menu_selection
    process(@io.gets.chomp)
  end

  def menu_selection
    @io.puts "\n" "What would you like to do?"
    @io.puts "\n 1 - list all shop items"
    @io.puts "\n 2 - create a new items"
    @io.puts "\n 3 - list all orders"
    @io.puts "\n 4 - create a new order"
    @io.puts "Enter your choice:"
  end

  def process(selection)
    case selection
    when "1"
      print_items
    when "2"
      create_item
    when "3"
      print_orders
    when "4"
      create_order
    else
      @io.puts "I dont know what you said, try again"
    end
  end

  def print_items
    @io.puts "\nHere's a list of all shop items:"
    @item_repository.all.each do |item|
      @io.puts "##{item.id} - #{item.item_name} - Unit Price: #{item.item_price} - Quantity: #{item.item_quantity}"
    end
  end

  def print_orders
    @io.puts "\nHere's a list of all orders:"
    @order_repository.all.each do |order|
      @io.puts "ID:#{order.id},#{order.customer_name},Date: #{order.order_date}"
    end
  end

  def create_item
    new_item = Item.new
    new_item.item_name = get_item_name
    new_item.item_price = get_item_price
    new_item.item_quantity = get_item_quantity
    @item_repository.create(new_item)
    @io.puts "#{new_item.item_quantity} X #{new_item.item_name} added to stock!"
  end

end

private

def get_item_name
  @io.puts "Enter item name:"
  item_name = @io.gets.chomp
end

def get_item_price
  @io.puts "Enter unit price:"
  item_price = @io.gets.chomp

  while item_price.to_i <= 0
    @io.puts "Price must be above zero"
    item_price = @io.gets.chomp
  end

  item_price.to_f
end

def get_item_quantity
  @io.puts "Enter item quantity:"
  item_quantity = @io.gets.chomp

  while item_quantity.to_i <= 0
    @io.puts "Quantity must be above zero"
    item_quantity = @io.gets.chomp
  end

  item_quantity.to_i
end

if __FILE__ == $0
  app = Application.new(
    "shop_manager",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end


