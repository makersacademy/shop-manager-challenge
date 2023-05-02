require_relative './function_repo'
require_relative './item_repo'
require_relative './order_repo'
require_relative './item'
require_relative './order'

class IOManager
  def initialize(io)
    @io = io
    @function_repo = FunctionRepo.new
    @item_repo = ItemRepo.new
    @order_repo = OrderRepo.new
  end

  def run
    greeter
    list_options
    case_handler(input)
  end

  private 

  def input
    return @io.gets.chomp
  end

  def case_handler(input)
    new_line
    case input
    when "1"
      list_items
    when "2"
      create_item
    when "3"
      list_orders
    when "4"
      create_order 
    else
      exit
    end
  end
  
  def greeter
    @io.puts "Welcome to the shop management program."
    new_line
  end

  def list_options
    @io.puts "What do you want to do?"
    functions = @function_repo.all
    functions.each do |function|
      @io.puts "#{function.id} = #{function.function}"
    end
    new_line
  end

  def list_items
    @io.puts "Here's a list of all shop items:"
    new_line
    items = @item_repo.all
    items.each do |item|
      @io.puts "#{item.id}. #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
    new_line
  end

  def create_item
    item = Item.new
    @io.print("Item name: ")
    item.name = input
    @io.print("Item price: ")
    item.unit_price = input
    @io.print("Item quantity: ")
    item.quantity = input
    @item_repo.create_item(item)
  end

  def list_orders
    orders = @order_repo.all
    orders.each do |order|
      @io.puts "#{order.customer_name} - #{order.order_date}"
      order.items.each do |item|
        @io.puts "* #{item.name}"
      end
      new_line
    end
  end

  def create_order
    @io.print "Enter customer name: "
    customer_name = input
    order = Order.new
    order.customer_name = customer_name
    order.order_date = Date.today
    @order_repo.create_order(order)
    new_line
    # This block returns the order_id of the last created order
    sql = 'SELECT id FROM orders WHERE customer_name = $1 ORDER BY id DESC;'
    result = DatabaseConnection.exec_params(sql, [order.customer_name])
    
    assign_items(result.first['id'])
  end

  def assign_items(order_id)
    while true
      @io.print "Add item to order: "
      item_to_add = input
      if item_to_add.empty?
        new_line
        break
      else
        @order_repo.add_item_to_order(item_to_add, order_id)
      end
    end
  end

  def new_line
    @io.puts ""
  end
end
