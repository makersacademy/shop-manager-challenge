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
    print_header
    interactive_menu
    print_footer
  end

  def print_header
    @io.puts 'Welcome to the sweet shop management program!'
  end

  def print_footer
    @io.puts 'Thank you for using the sweet shop management program!'
  end

  def interactive_menu
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    selection = @io.gets.chomp

    case selection
      when "1" then items
      when "2" then add_item
      when "3" then orders
      when "4" then add_order
      when "5" then order_by item
    end
  end

  private

  def items
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    @io.puts "Here is the list of current inventory:"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      puts record.values.join(" - ")
    end
  end

  def add_item
    item = Item.new
    @io.puts "Please enter item name"
    item.item_name = @io.gets.chomp
    @io.puts "Please enter item price"
    item.item_price = @io.gets.chomp
    @io.puts "Please enter item quantity"
    item.item_quantity = @io.gets.chomp
    @item_repository.create(item)
    @io.puts 'Item created'
  end
end

def orders
  sql = 'SELECT id, customer_name, order_date FROM orders;'
  @io.puts "Here is a list of all the orders:"

  result_set = DatabaseConnection.exec_params(sql, [])
  result_set.each do |record|
    puts record.values.join(" - ")
  end
end

def add_order
  order = Order.new
  @io.puts "Please enter customer name"
  order.customer_name = @io.gets.chomp
  @io.puts "Please enter an order date"
  order.order_date = @io.gets.chomp
  @order_repository.create(order)
  @io.puts 'Order created'
end

if __FILE__ == $0
  app = Application.new(
    'shop_challenge_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
