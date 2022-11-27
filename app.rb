# file: app.rb

require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    prompt
    input = @io.gets.chomp
    @io.puts ""
    case input
      when "1" then list_items
      when "2" then create_item
      when "3" then list_orders
      when "4" then create_order
      else @io.puts "Request not recognized"
    end
  end

  private

  def prompt
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new shop order"
    @io.puts ""
  end

  def list_items
    @io.puts "Here's a list of all shop items:"
    @io.puts ""
    @item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}"
    end
  end

  def list_orders
    @io.puts "Here's a list of all orders:"
    @io.puts ""
    i = 0
    number_of_orders = @order_repository.all.length
    loop do
      i += 1
      if i > number_of_orders then break end
      order = @order_repository.find_with_item(i)
      @io.puts "##{i} #{order.customer} - Date: #{order.date}"
      order.items.each {|item| @io.puts "   #{item.name}"}
    end
  end
  
  def create_item
    item = Item.new
    @io.puts "Item name:"
    item.name = @io.gets.chomp
    @io.puts "Item price:"
    item.price = @io.gets
    @io.puts "Item quantity:"
    item.quantity = @io.gets
    @item_repository.create(item)
  end

  def create_order
    order = Order.new
    @io.puts "Customer name:"
    order.customer = @io.gets.chomp
    @io.puts "Order date:"
    order.date = @io.gets.chomp
    @io.puts "Item ordered:"
    item_id = @io.gets.chomp
    item = @item_repository.find(item_id)
    @order_repository.create(order, item)
  end

  if __FILE__ == $0
    app = Application.new(
      'shop_inventory',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end
end
