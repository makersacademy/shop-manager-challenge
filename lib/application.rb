class Application
  def initialize(io:, order_repository:, item_repository:)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    menu
    input = @io.gets.chomp
    print_all_items if input == '1'
    add_item if input == '2'
    print_all_orders if input == '3'
    add_order if input == '4'
  end

  private

  def menu 
    @io.puts 'Select an item from the menu:'
    @io.puts '1 - list all shop items'
    @io.puts '2 - create a new item'
    @io.puts '3 - list all orders'
    @io.puts '4 - create a new order'
  end

  def print_all_orders
    @io.puts 'Here is a list of all orders'
    orders = @order_repository.all_with_item
    orders.each do |order|
      @io.puts('Order:')
      @io.puts "#{order.id} - Customer: #{order.customer} - Date: #{order.date}"
      @io.puts('Item:')
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
    item_id = prompt "Item ID:"
    order = Order.new(
      customer: customer,
      date: date
    )
    order.item_id = item_id
    @order_repository.create(order)
    @io.puts('Order created.')
  end

  def add_item
    name = prompt "Item name:"
    price = prompt "Unit price:"
    stock = prompt "Stock:"
    item = Item.new(
      name: name,
      price: price,
      stock: stock
    )
    @item_repository.create(item)
    @io.puts 'Item created.'
  end

  def prompt(message)
    @io.puts message
    @io.gets.chomp
  end
end
