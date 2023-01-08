require_relative "lib/database_connection"
require_relative "lib/items_repository"
require_relative "lib/orders_repository"
require_relative "lib/orders"
require_relative "lib/items"
DatabaseConnection.connect("shop_manager_test")

class Application
  def initialize(database_name, io, orders_repository, items_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @orders_repository = orders_repository
    @items_repository = items_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"

    @io.puts "What do you want to do? \n1 - List all shop items \n2 - Create a new item \n3 - List all orders \n4 - Create a new order \nEnter your choice: "
    choice = @io.gets.to_i

    if choice == 1
      @io.puts "Here is your list of shop items:"
      @items_repository.all.each do |record|
        @io.puts "##{record.id} - #{record.name} - £#{record.price} - Quantity: #{record.quantity}"
      end
    elsif choice == 2
      @io.puts "Enter the name of the item:"
      item = Items.new
      item.name = @io.gets.chomp
      @io.puts "Enter the price of the item"
      item.price = @io.gets.chomp
      @io.puts "Enter the quantity of the item"
      item.quantity = @io.gets.to_i
      @items_repository.create(item)
    elsif choice == 3
      @orders_repository.all.each do |record|
        puts "Customer name: #{record.customer_name} - Date ordered: #{record.date} - Item: #{record.items.first.name} - Price: £#{record.items.first.price}"
      end
    elsif choice == 4
      order = Orders.new
      @io.puts "Enter the customers name"
      order.customer_name = @io.gets.chomp
      @io.puts "Enter the date of the order"
      order.date = @io.gets.chomp
      @io.puts "Choose the number of the item you want to assign to the order"
      @items_repository.all.each do |record|
        @io.puts "##{record.id} - #{record.name}"
      end
      item_id = @io.gets.to_i
      @orders_repository.create(order, item_id)
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    "shop_manager",
    Kernel,
    OrdersRepository.new,
    ItemsRepository.new
  )
  app.run
end
