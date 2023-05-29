require 'date'
require_relative './lib/order_repository'
require_relative './lib/item_repository'
require_relative './lib/order_item_repository'
require_relative './lib/database_connection'

class Application
  def initialize(database_name, io, item_repository, order_repository, order_item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @order_item_repository = order_item_repository
  end

  def run
    @io.puts "----------------------------------------------"
    @io.puts "Welcome to the shop management program!\n\n"
    @io.puts "What do you want to do?"
    @io.puts " 1 = list all shop items"
    @io.puts " 2 = create a new item"
    @io.puts " 3 = list all orders"
    @io.puts " 4 = create a new order"

    @io.print "\nEnter your choice: "
    choice = @io.gets.chomp.to_i

    case choice
    when 1
      @io.puts "\nHere's a list of all shop items:"
      items = @item_repository.all
      items.each do |item|
        @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price}" \
         " - Quantity: #{item.quantity}"
      end
    when 2
      @io.puts "\nCreating a new item..."
      @io.print "Enter item name: "
      item_name = @io.gets.chomp
      @io.print "Enter unit price: "
      unit_price = @io.gets.chomp.to_f
      @io.print "Enter quantity: "
      quantity = @io.gets.chomp.to_i
    
      new_item = Item.new
      new_item.name = item_name
      new_item.unit_price = unit_price
      new_item.quantity = quantity
    
      @item_repository.create(new_item)
      @io.puts "\nNew item created successfully.\n"
    when 3
      @io.puts "\nHere's a list of all orders:"
      orders = @order_repository.all
      orders.each do |order|
        @io.puts " ##{order.id} - Customer Name: #{order.customer_name}" \
         " - Order Date: #{order.order_date}\n"
      end
    when 4
      @io.puts "\nCreating a new order..."
      @io.print "Enter customer name: "
      customer_name = @io.gets.chomp
      order_date = Date.today

      new_order = Order.new
      new_order.customer_name = customer_name
      new_order.order_date = order_date

      @order_repository.create(new_order) # Create the order

      @io.puts "\nNew order created successfully.\n"

      # Prompt to add items to the order
      loop do
        @io.print "Do you want to add an item to this order? (y/n):\n "
        add_item_choice = @io.gets.chomp.downcase

        break if add_item_choice != 'y'
        items_show = @item_repository.all
        items_show.each do |item|
          @io.puts " ##{item.id} #{item.name} - Unit price: #{item.unit_price}" \
         " - Quantity: #{item.quantity}"
        end
        order_all = @order_repository.all
        @io.puts "----------------------------------------------------"
        @io.print "Enter the ID of the item to add: "
        item_id_input = @io.gets.chomp
        item_id = item_id_input.to_i

        if item_id.to_s == item_id_input && !item_id.zero?
          item = @item_repository.find(item_id)
          if item
            @order_item_repository.create(order_all.last.id, item.id)
            @io.puts "Item added to the order.\n"
          else
            @io.puts "Invalid item ID. Please try again.\n"
          end
        else
          @io.puts "Invalid item ID. Please try again.\n"
        end
      end
    else
      @io.puts "\nInvalid choice. Please try again."
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
    OrderItemRepository.new
  )
  app.run
end
