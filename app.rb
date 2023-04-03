require_relative "./lib/item_repository"
require_relative "./lib/order_repository"
require_relative "./lib/database_connection"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts "Welcome to the shop management program!"

    while true
      @io.puts ""
      @io.puts "What do you want to do?"
      @io.puts "1 - list all shop items"
      @io.puts "2 - create a new item"
      @io.puts "3 - list all orders"
      @io.puts "4 - create a new order"
      @io.puts "any other key to exit"
      choice = @io.gets.chomp.to_i

      case choice
      when 1
        @io.puts "Here's a list of all shop items:"
        @item_repository.all.each_with_index do |item, index| 
          @io.puts "##{index + 1} #{item.name} - Unit price: £#{item.unit_price} - Quantity: #{item.quantity}"
        end

      when 2
        @io.puts "Enter the item name:"
        name = @io.gets.chomp
        @io.puts "Enter the item's unit price:"
        unit_price = @io.gets.chomp.to_f.round(2)
        @io.puts "Enter the item's quantity:"
        quantity = @io.gets.chomp

        item = Item.new
        item.name = name
        item.unit_price = unit_price
        item.quantity = quantity
        @item_repository.create(item)
        @io.puts "'#{name}' was added to the database!"

      when 3
        @io.puts "Here's a list of all shop orders:"
        @order_repository.all.each_with_index do |order, index| 
          @io.puts "##{index + 1} Order ID: #{order.id} - Customer name: #{order.customer_name} - Order date: #{order.order_date} - Item: #{order.item}"
        end

      when 4
        @io.puts "Enter the customer's name:"
        name = @io.gets.chomp
        @io.puts "Enter the item's ID number:"
        item_id = @io.gets.chomp.to_i
        # Check if the item ID exists
        @item_repository.item_exists?(item_id)
        order = Order.new
        order.customer_name = name
        order.order_date = Time.now.strftime("%Y-%m-%d")
        @order_repository.create(order, item_id)
        @io.puts "An order for '#{name}' was created!"

      else
        abort("Goodbye!")
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