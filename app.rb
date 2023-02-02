require_relative "lib/database_connection"
require_relative "lib/item_repository"
require_relative "lib/order_repository"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    menu

    input = @io.gets.chomp.to_i

    case input
    when 1
      list_items
    when 2
      create_item
    when 3
      list_orders
    when 4
      create_order
    else
      @io.puts "Invalid input"
    end
  end

  private

  def menu
    @io.puts <<~MENU
      Welcome to the shop management program!

      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order

    MENU
  end

  def list_items
    @io.puts "Here's a list of all shop items:"

    @io.puts @item_repository.all.map { format_item(_1) }.join("\n")
  end

  def format_item(item)
    "Item #: #{item.id} | #{item.name} | Unit Price: #{item.unit_price} | Quantity: #{item.quantity}"
  end

  def create_item
    @io.puts "New item:"
    @io.print "Item name: "
    name = @io.gets.chomp
    @io.print "Unit price (integer): "
    price = @io.gets.chomp.to_i
    @io.print "Quantity: "
    quantity = @io.gets.chomp.to_i

    new_item = Item.new(name: name, unit_price: price, quantity: quantity)
    @item_repository.create(new_item)
    @io.puts "Item created!"
  end

  def list_orders
    @io.puts "Here's a list of all orders:"

    @io.puts @order_repository.all.map { format_order(_1) }.join("\n")
  end

  def format_order(order)
    date = Date.parse(order.date).strftime("%d/%m/%y")
    "Order #: #{order.id} | Customer: #{order.customer_name} | Date: #{date} | Item #: #{order.item_id}"
  end

  def create_order
    @io.puts "New order:"
    @io.print "Item #: "
    item_no = @io.gets.chomp.to_i
    @io.print "Your name: "
    name = @io.gets.chomp

    date = Time.now.strftime("%Y-%m-%d")

    new_order = Order.new(customer_name: name, date: date, item_id: item_no)
    @order_repository.create(new_order)
    @io.puts "Order created!"
  end

end

if __FILE__ == $PROGRAM_NAME
  app = Application.new(
    "shop",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
