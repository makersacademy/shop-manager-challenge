require_relative 'database_connection'
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
    user_choice = 0 
    while user_choice != 1 && user_choice != 2 && user_choice != 3 && user_choice != 4
      @io.puts "Welcome to your car showroom management program!"
      @io.puts "What would you like to do?"
      @io.puts "1 - List all items"
      @io.puts "2 - Create a new item"
      @io.puts "3 - List all orders"
      @io.puts "4 - Create a new order"
      user_choice = @io.gets.to_i

      if user_choice == 1
        @io.puts "Here's a list of shop items:"
        results = @item_repository.all
        results.each do |record| 
          @io.puts "*#{record.id} Model: #{record.name} - Price: #{record.price} - Quantity: #{record.quantity}"
        end

      elsif user_choice == 2 
        new_item = Item.new
        @io.puts "Enter model"
        new_item.name = @io.gets.chomp
        @io.puts "Enter price"
        new_item.price = @io.gets
        @io.puts "Enter quantity"
        new_item.quantity = @io.gets.to_i
        @item_repository.create(new_item)
      
      elsif user_choice == 3
        @io.puts "Here's a list of orders:"
        results = @order_repository.all
        results.each do |record|
          @io.puts "* Name: #{record.customer_name} - Date: #{record.date} - Item ID: #{record.item_id}" 
        end

      elsif user_choice == 4 
        new_order = Order.new
        @io.puts "Enter name"
        new_order.customer_name = @io.gets.chomp
        @io.puts "Enter date"
        new_order.date = @io.gets
        @io.puts "Enter item ID"
        new_order.item_id = @io.gets.to_i
        @order_repository.create(new_order)
        @item_repository.update_quantity(2)
      end
    end
  end
end


  if __FILE__ == $0
    app = Application.new(
      'shop_manager',
      Kernel,
      ItemRepository.new,
      OrderRepository.new
    )
    app.run
  end