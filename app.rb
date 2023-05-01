require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application 

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    selection = @io.gets.chomp
    if selection == "1"
      @item_repository.all.each { |item| @io.puts "##{item.id} - #{item.item_name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}" }
    elsif selection == "2"
      item = Item.new
      @io.puts "Enter the items name:"
      item.item_name = @io.gets.chomp
      @io.puts "Enter the items unit price:"
      item.unit_price = @io.gets.chomp
      @io.puts "Enter the items quantity:"
      item.quantity = @io.gets.chomp
      @item_repository.create(item)
      @io.puts "#{item.item_name} has been added to your inventory"
    elsif selection == "3"
      @order_repository.all.each { |order| @io.puts "##{order.id} - Customer name: #{order.customer_name} - Date placed: #{order.date_placed}" }
    elsif selection == "4"
      nil
    else
      nil
    end
  end
end

# name = 'shop_manager'
# io = Kernel
# item_repo = ItemRepository.new
# order_repo = OrderRepository.new
# app = Application.new(name, io, item_repo, order_repo)
# app.run
