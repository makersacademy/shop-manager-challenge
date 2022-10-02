require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application

  def initialize(io, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager')
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts("Welcome to the shop managment program!")
    @io.puts("")
    @io.puts("1 = list all shop items")
    @io.puts("2 = create a new item")
    @io.puts("3 = list all orders")
    @io.puts("4 = create a new order")

    user_choice(@io.gets.chomp)

    return nil
  end

  def user_choice(input)
    fail "Please enter a valid number" unless (1..4).include?(input.to_i)

    case input
    when '1'
      list_items
    when '2'
      create_item
    when '3'
      list_orders
    when '4'
      create_order
    end
  end

  def list_items
    @io.puts('Here is a list of all shop items:')
    all_items = @item_repository.all
    
    all_items.each do |item|
      @io.puts "##{item.id} 
      #{item.name} 
      - Unit price: #{item.price} 
      - Quantity: #{item.quantity}"
    end
  end

  def create_item
    @io.puts ('Please give the item name:')
    item_name = @io.gets.chomp
    @io.puts ('Please give the unit price:')
    item_price = @io.gets.chomp
    @io.puts ('Please give the item quantity:')
    item_quantity = @io.gets.chomp

    new_item = Item.new
    new_item.name = item_name
    new_item.price = item_price
    new_item.quantity = item_quantity

    repo = ItemRepository.new
    repo.create(new_item)
  
  end

  def list_orders
    @io.puts('Here is a list of all orders:')
    all_orders = @order_repository.all
    
    all_orders.each do |order|
      @io.puts "##{order.id} 
      #{order.customer_name} 
      - Order date: #{order.order_date} 
      - Item ID: #{order.item_id}"
    end
  end

  def create_order
    @io.puts ('Please give the order name:')
    order_customer_name = @io.gets.chomp
    @io.puts ('Please give the order date:')
    order_date = @io.gets.chomp
    @io.puts ('Please give the item id:')
    item_id = @io.gets.chomp

    new_order = Order.new
    new_order.customer_name = order_customer_name
    new_order.order_date = order_date
    new_order.item_id = item_id

    repo = OrderRepository.new
    repo.create_with_items(new_order)
  
  end

end

if __FILE__ == $0
  app = Application.new(
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
