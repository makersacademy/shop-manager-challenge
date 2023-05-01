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
      @item_repository.all.each do |item| 
        @io.puts "##{item.id} - #{item.item_name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
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
      @order_repository.all.each do |order| 
        @io.puts "##{order.id} - Customer name: #{order.customer_name} - Date placed: #{order.date_placed}"
      end
    elsif selection == "4"
      order = Order.new
      @io.puts "Enter the customer name for this order:"
      order.customer_name = @io.gets.chomp
      @io.puts "When was this this order placed?:"
      order.date_placed = @io.gets.chomp
      @io.puts "Enter the item id assosciated with this order:"
      order.item_id = @io.gets.chomp
      @order_repository.create(order)
      @io.puts "#{order.customer_name}'s order has been added to your order list"
    else
      fail "This is not a valid selection"
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
