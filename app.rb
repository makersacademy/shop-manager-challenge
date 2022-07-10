require_relative './lib/order_repository'
require_relative './lib/item_repository'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts("Welcome to the shop management program!")
    @io.puts("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n")
    user_input = @io.gets
    case user_input 
      when "1\n"
        print_items
      when "2\n"
        create_item
      when "3\n"
        print_orders
      when "4\n"
        create_order
    end
  end
end


private
  
def create_item
  @io.puts("Enter item details:")
  item_details = @io.gets.chomp.split(", ")
  item = Item.new
  item.name = item_details[0]
  item.price = item_details[1].to_f
  item.quantity = item_details[2].to_i
  @item_repository.create(item)
  @io.puts("Item Created!")
end

def create_order
  @io.puts("Enter order details:")
  order_details = @io.gets.chomp.split("| ")
  order = Order.new
  order.customer_name = order_details[0]
  order.order_date = order_details[1]
  order.item_id = order_details[2].to_i
  @order_repository.create(order)
  @io.puts("Order Created!")
end

def print_orders
  @io.puts("Here's a list of all orders:")
  @order_repository.all.each do |order| 
    @io.puts "Order id: ##{order.id} #{order.customer_name}, #{order.order_date}, item_id: #{order.item_id}"
  end
end

def print_items
  @io.puts("Here's a list of all shop items:")
  @item_repository.all.each do |item| 
    @io.puts "##{item.id} #{item.name} - Item price: #{item.price} - Quantity: #{item.quantity}"
  end
end

# If we run this file using `ruby app.rb`,
# run the app.
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
