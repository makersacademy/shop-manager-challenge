require_relative 'lib/order_repository'
require_relative 'lib/item_repository'
require_relative 'lib/database_connection'


class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_menu
    user_input = @io.gets.chomp.to_i

    case user_input
    when 1
      list_all_items
    when 2
      create_new_item
    when 3
      list_all_orders
    when 4
      create_new_order
    end
    
  end

  private

  def print_menu
    @io.puts (
      "Welcome to the shop management program!
      
      What do you want to do?
        1 = list all shop items
        2 = create a new item
        3 = list all orders
        4 = create a new order"
      )
  end

  def list_all_items
    @item_repository.all.each do |record|
      @io.puts("##{record.id} #{record.name} - Unit price: #{record.unit_price} - Quantity: #{record.quantity}")
    end
  end

  def create_new_item
    new_item = Item.new

    @io.puts "Please enter the new item's name:"
    new_item.name = @io.gets.chomp
    @io.puts "Please enter the new item's unit price:"
    new_item.unit_price = @io.gets.chomp.to_f
    @io.puts "Please enter the new item's quantity:"
    new_item.quantity = @io.gets.chomp.to_i

    @item_repository.create(new_item)
  end

  def list_all_orders
    @order_repository.all.each do |record|
      @io.puts("Date: #{record.date} - Order ID #{record.id} - Customer Name: #{record.customer_name} - item_id: #{record.item_id}")
    end
  end

  def create_new_order
    new_order = Order.new

    @io.puts "Please enter the date (YYYY-MM-DD):"
    new_order.date = @io.gets.chomp
    @io.puts "Please enter the customer's name:"
    new_order.customer_name = @io.gets.chomp
    @io.puts "Please enter the item ID:"
    new_order.item_id = @io.gets.chomp.to_i

    @order_repository.create(new_order)
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
