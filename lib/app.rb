require_relative './item.rb'
require_relative './order.rb'
require_relative './item_repository.rb'
require_relative './order_repository.rb'
require_relative './database_connection.rb'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @item_repository = item_repository
    @order_repository = order_repository
    @io = io
  end

  def list_items
    @item_repository.all
  end

  def list_orders
    @order_repository.all
  end

  def create_item

    item = Item.new()

    @io.puts "ID:"
    item.id = @io.gets.chomp.to_i
    @io.puts "item name:"
    item.name = @io.gets.chomp
    @io.puts "item unit price:"
    item.unit_price = @io.gets.chomp.to_f
    @io.puts "quantity of item:"
    item.quantity = @io.gets.chomp.to_i

    @item_repository.create(item)

  end

  def create_order

    order = Order.new

    @io.puts "ID:"
    order.id = @io.gets.chomp
    @io.puts "customer name:"
    order.customer_name = @io.gets.chomp
    @io.puts "order date:"
    order.date = @io.gets.chomp
    @io.puts "ID of item ordered:"
    order.item_id = @io.gets.chomp

    @order_repository.create(order)

  end

  def run

    @io.puts "Welcome to the shop manager!"

    @io.puts "What would you like to do?"
    @io.puts "1 - List all items"
    @io.puts "2 - List all orders"
    @io.puts "3 - Add an item"
    @io.puts "4 - Add an order"

    @io.puts "Enter Your Choice:"
    selection = @io.gets.chomp

    if selection == "1"
      list_items
    elsif selection == "2"
      list_orders
    elsif selection == "3"
      create_item
    elsif selection == "4"
      create_order
    else
      @io.puts "Not a valid option."
    end

  end

end


 if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new(Kernel),
    OrderRepository.new(Kernel)
  )
  app.run
end
