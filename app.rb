require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

item_repository = ItemRepository.new
order_repository = OrderRepository.new

class Application
    def initialize(database_name, io, order_repository, item_repository)
      DatabaseConnection.connect(database_name)
      @io = io
      @order_repository = order_repository
      @item_repository = item_repository
    end
  
    def run
      puts "Welcome to the shop management program!"
      @io.puts "\nWhat do you want to do" "\n 1 = list all shop items \n 2 = create a new item \n 3 = list all orders \n 4 = create a new order"
      choice = @io.gets.chomp
  
          if choice == '1' 
              @item_repository.all.each do |record|
              puts "* Item ID: #{record.id} - Item: #{record.name} - Item quantity: #{record.quantity}"
              end
            elsif choice == '2'
                new_entry = ItemRepository.new
                new_item = Item.new
                @io.puts "What is the item name?"
                new_item.name = @io.gets.chomp
                @io.puts "What is the item price?"
                new_item.price = @io.gets.chomp
                @io.puts "What is the item quantity?"
                new_item.quantity = @io.gets.chomp
                new_entry.create(new_item)
            elsif choice == '3'
              @order_repository.all.each do |record|
              puts "* Customer id: #{record.id} - Customer name: #{record.customer} - Order date: #{record.date} - Order ID: #{record.item_id}"
              end
              else choice == '4'
                new_entry = OrderRepository.new
                new_order = Order.new
                @io.puts "What is the customer's name?"
                new_order.customer = @io.gets.chomp
                @io.puts "What is the order date?"
                new_order.date = @io.gets.chomp
                @io.puts "What is the associated item ID?"
                new_order.item_id = @io.gets.chomp
                new_entry.create(new_order)
        end
    end
  end
  
  if __FILE__ == $0
    app = Application.new(
      'shop_manager',
      Kernel,
      OrderRepository.new,
      ItemRepository.new
    )
    app.run
  end