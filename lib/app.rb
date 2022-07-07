require_relative "./item_repository"
require_relative "./order_repository"
require_relative "./database_connection"

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts("Welcome to the shop management program!")
    @io.puts("\nWhat do you want to do?\n  1 = list all shop items\n  2 = create a new item\n  3 = list all orders\n  4 = create a new order")

    choice = @io.gets.chomp

    if choice == "1"
      @item_repository.all.each do |item|
        @io.puts("Item #{item.id}: #{item.name}, Unit Price: #{item.price}")
      end
    elsif choice == "2"
      @io.puts("Enter name of item you would like to create")
      name = @io.gets.chomp
      @io.puts("Enter price of item you would like to create")
      price = @io.gets.chomp
      item = Item.new
      item.name = name
      item.price = price

      @item_repository.create(item)
      @io.puts("This is your new list of items")
      @item_repository.all.each do |item|
        @io.puts("Item #{item.id}: #{item.name}, Unit Price: #{item.price}")
      end
    elsif choice == "3"
      @order_repository.all.each do |order|
        @io.puts("#{order.customer_name}, #{order.order_date}: #{@item_repository.all[order.item_id - 1].name}")
      end
    elsif choice == "4"
      @io.puts("Enter customer name of the order you would like to create")
      customer_name = @io.gets.chomp
      @io.puts("Enter the order date of the order you would like to create")
      order_date = @io.gets.chomp
      @io.puts("Enter the item id of the order you would like to create")
      item_id = @io.gets.chomp

      order = Order.new
      order.customer_name = customer_name
      order.order_date = order_date
      order.item_id = item_id

      @order_repository.create(order)
      @io.puts("This is your new list of orders")
      @order_repository.all.each do |order|
        @io.puts("#{order.customer_name}, #{order.order_date}: #{@item_repository.all[order.item_id - 1].name}")
      end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    "shop_manager_test",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
