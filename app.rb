require_relative "lib/item_repository"
require_relative "lib/order_repository"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    loop do
      print_menu
      user_choice = @io.gets.to_i
      options(user_choice)
    end
  end

  def options(choice)
    view_all_items if choice == 1
    item_creation if choice === 2
    view_all_orders if choice == 3
    order_creation if choice == 4
    exit if choice.zero?
    @io.puts "Not a valid inout" if choice > 4
  end

  def item_creation
    item_repo = ItemRepository.new(@io)
    item_repo.add_item
  end

  def order_creation
    order_repo = OrderRepository.new(@io)
    order_repo.add_order
  end

  def print_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts "What do you want to do?"
    @io.puts "1- View all items"
    @io.puts "2- Add a new item"
    @io.puts "3- View all orders"
    @io.puts "4- Add a new order"
    @io.puts "0- To exit"
  end
    
  def view_all_items
    item_repo = ItemRepository.new(@io)
    @io.puts "Items:"
    @io.puts "-----------------------"
    items = []
    item_repo.all_items.each do |item|
      @io.puts "#{item.name}, ID- #{item.id}, Price- £#{item.price}, Quantity- #{item.quantity}"
      @io.puts "-----------------------"
    end
  end
      
  def view_all_orders
    order_repo = OrderRepository.new(@io)
    @io.puts "Orders:"
    @io.puts "-----------------------"
    orders = []
    order_repo.all_orders.each do |order|
      @io.puts "#{order.customer_name}, #{order.id}, Date placed-#{
        order.order_date}, ID-#{order.item_id}"
      @io.puts "-----------------------"
    end
    return nil
  end  
end

app = Application.new(
  'shop_manager',
  Kernel,
   ItemRepository.new(@io),
  OrderRepository.new(@io)
)
app.run
