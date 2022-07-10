require_relative './lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/order_repository'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect('shop_test')
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts ("Welcome to the your shop manager!")
    @io.puts ("\nWhat would you like to do?\n 1 = list all items\n 2 = Create a new item\n 3 = List all orders\n 4 = Create a new order")

    choice = @io.gets.chomp

    if choice == "1"
      @item_repository.all.each do |item|
        @io.puts ("#{item.id}: #{item.item}, #{item.price}, #{item.quantity}")
      end
    elsif choice == "2"
      @io.puts("Enter the name or the item you would like to create")
      name = @io.gets.chomp
      @io.puts("Enter the price of the new item")
      price = @io.gets.chomp
      @io.puts("How many of these do you have?")
      quantity = @io.gets.chomp
      item = Item.new
      item.item = name
      item.price = price
      item.quantity = quantity

      @item_repository.create(item)
      @io.puts("Here is your updated list of items")
      @item_repository.all.each do |item|
        @io.puts("Item #{item.id}: #{item.item}, #{item.price}, #{item.quantity}")
      end
    elsif choice == "3"
      @order_repository.all.each do |order|
        @io.puts("#{order.customer_name}, #{order.date_ordered}: #{@item_repository.all[order.item_id - 1].item}")
    end
    elsif choice == "4"
      @io.puts("Enter the customer name")
      customer_name = @io.gets.chomp
      @io.puts ("Enter the order date")
      date_ordered = @io.gets.chomp
      @io.puts("Enter the item id for this order")
      item_id = @io.gets.chomp

      order = Order.new
      order.customer_name = customer_name
      order.date_ordered = date_ordered
      order.item_id = item_id

      @order_repository.create(order)
      @io.puts("This is your new list of orders")
      @order_repository.all.each do |order|
        @io.puts ("#{order.customer_name}, #{order.date_ordered}: #{@item_repository.all[order.item_id - 1].item}")
      end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    "shop_test",
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end