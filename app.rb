require_relative "lib/database_connection"
require_relative "lib/item_repository"
require_relative "lib/order_repository"
require_relative "lib/item"
require_relative "lib/order"

class Application
  def initialize(database_name, terminal, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @terminal.puts "Welcome to the shop management program!"

    @terminal.puts "What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"

    user_input = @terminal.gets.chomp
    case user_input
    when "1"
      @item_repository.all.each_with_index do |item, index|
        @terminal.puts "##{index + 1} #{item.item_name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
      end
    when "2"
      item = Item.new
      @terminal.puts "What is the item name?"
      item.item_name = @terminal.gets.chomp
      @terminal.puts "What is the item price?"
      item.price = @terminal.gets.chomp
      @terminal.puts "What is the item quantity?"
      item.quantity = @terminal.gets.chomp

      @item_repository.create(item)
      @terminal.puts "Your item has been added"
    when "3"
      @order_repository.all.each_with_index do |order, index|
        @terminal.puts "##{index + 1} Customer Name: #{order.customer_name} - Order Date: #{order.order_date}"
      end
    when "4"
      order = Order.new
      @terminal.puts "What is the customer name?"
      order.customer_name = @terminal.gets.chomp
      @terminal.puts "What is the order date?"
      order.order_date = @terminal.gets.chomp

      @order_repository.create(order)
      @terminal.puts "Your order has been added"
    else
    end
  end

  # Don't worry too much about this if statement. It is basically saying "only
  # run the following code if this is the main file being run, instead of having
  # been required or loaded by another file.
  # If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
  if __FILE__ == $0
    app =
      Application.new(
        "shop_manager",
        Kernel,
        ItemRepository.new,
        OrderRepository.new,
      )
    app.run
  end
end
