require_relative 'lib/database_connection'
require_relative 'lib/items_repository'
require_relative 'lib/items'
require_relative 'lib/orders_repository'

class Application

  def initialize(database_name, io, items_repository, orders_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @items_repository = items_repository
    @orders_repository = orders_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.
    @io.puts('Welcome to the shop management program!')
    @io.puts('What do you want to do?')
    @io.puts('1 = list all shop items')
    @io.puts('2 = create a new item')
    @io.puts('3 = list all orders')
    @io.puts('4 = create a new order')

    choice = @io.gets.chomp
    if choice == '1'
      @io.puts("Here is the list of items:")

      @items_repository.all.each do |item|
        @io.puts("#{item.id} - #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}")
      end
    elsif choice == '2'
      @io.puts("What is the name of the item")
      item_name = @io.gets.chomp

      @io.puts("What is the price of the item")
      item_unit_price = @io.gets.chomp

      @io.puts("What is the quantity of the item")
      item_quantity = @io.gets.chomp

      new_item = Items.new
		  new_item.name = item_name
		  new_item.unit_price = item_unit_price
		  new_item.quantity = item_quantity
		  @items_repository.create(new_item)

      @io.puts("New Item Created")

    elsif choice == '3'
      @io.puts("Here is the list of orders:")

      @orders_repository.all.each do |order|
        @io.puts("#{order.id} - #{order.customer_name} - Order date: #{order.order_date} - Item id: #{order.item_id}")
      end
    elsif choice == '4'
      @io.puts("What is the name of the Customer")
      order_customer_name = @io.gets.chomp

      @io.puts("What is the date of the order")
      order_date_1 = @io.gets.chomp

      @io.puts("What is the item id")
      order_item_id = @io.gets.chomp

      new_order = Orders.new
		  new_order.customer_name = order_customer_name
		  new_order.order_date = order_date_1
		  new_order.item_id = order_item_id
		  @orders_repository.create(new_order)

      @io.puts("New Order Created")
    else 
      @io.puts('Wrong Input')
    end


    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end

end


if __FILE__ == $0
  app = Application.new('shop_directory', Kernel, ItemsRepository.new, OrdersRepository.new)
  app.run
end