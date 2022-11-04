require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application

  def initialize(io, item_repository, order_repository)
    DatabaseConnection.connect('shop_test')
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
    case input
    when '1'
      all_items
    when '2'
      create_item
    when '3'
      all_orders
    when '4'
      create_order
    end
  end

  def all_items
    @io.puts('Here is a list of all shop items:')
    all_items = @item_repository.all
    
    all_items.each do |item|
      @io.puts "##{item.id} #{item.name} - Price: #{item.price} - Quantity: #{item.quantity}"
    end
  end

  def create_item
    @io.puts('Please enter the item name:')
    item_name = @io.gets
    @io.puts('Please enter the item price:')
    item_price = @io.gets
    @io.puts('What quantity do we have?:')
    item_quantity = @io.gets
    item = Item.new
    item.name = item_name
    item.price = item_price
    item.quantity = item_quantity
    @item_repository.create(item)
    @io.puts('New item created and added to database.')
  end

  def all_orders
    @io.puts('Here is a list of all shop orders:')
    all_orders = @order_repository.all
    
    all_orders.each do |order|
      @io.puts "##{order.id} #{order.customer} - Order date: #{order.order_date}"
    end
  end
end

def create_order
  @io.puts('Please enter the customer name:')
  order_customer = @io.gets
  @io.puts('Please enter the order date:')
  order_date = @io.gets
  order = Order.new
  order.customer = order_customer
  order.order_date = order_date
  @order_repository.create(order)
  @io.puts('New order created and added to database.')
end

if __FILE__ == $0
  app = Application.new(
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
