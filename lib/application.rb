class Application
  def initialize(database_connection:, io:, order_repository:, item_repository:)
    @io = io
    @order_repository = order_repository
    @item_repository = ItemRepository.new(database_connection: @database_connection)
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    loop do
      menu
      input = @io.gets.chomp
      case input
      when '1' 
        print_all_items
      when '2'
        add_item
      when '3'
        print_all_orders
      when '4'
        add_order
      when '5'
        return
      end
    end
  end

  private

  def menu 
    @io.puts 'Select an item from the menu:'
    @io.puts '1 - list all shop items'
    @io.puts '2 - create a new item'
    @io.puts '3 - list all orders'
    @io.puts '4 - create a new order'
    @io.puts '5 - exit'
  end

  def print_all_orders
    @io.puts 'Here is a list of all orders'
    orders = @order_repository.all_with_items
    orders.each do |order|
      @io.puts "#{order.id} - Customer: #{order.customer} - Date: #{order.date}"
      print_item(order.item)
    end
  end

  def print_all_items
    @io.puts 'Here is a list of all items'
    items = @item_repository.all
    items.each do |item|
      print_item(item)
    end
  end

  def print_item(item)
    @io.puts "#{item.id} - #{item.name} - Unit price: #{item.price} - Quantity: #{item.stock}"
  end

  def add_order 
    customer = prompt "Customer name:"
    date = prompt "Order date:"
    item = propmt "Item id:"
    order = Order.new()
    @order_repository.create(order)
  end

  def add_item
    name = prompt "Item name:"
    price = prompt "Unit price:"
    stock = propmt "Quantity in stock:"
    item = Item.new()
    @item_repository.create(item)
  end

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end
end