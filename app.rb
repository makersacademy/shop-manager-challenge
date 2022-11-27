require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require 'date'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_intro
    loop do
      print_menu
      process(@io.gets.chomp)
      break # <-- uncomment this break to have the menu reprint so multiple operations
      # can be carried out e.g. list all items then make an order then list orders
    end
  end

  def process(selection)
    case selection
    when '1' then list_items
    when '2' then create_item
    when '3' then list_orders
    when '4' then create_order
    when '9' then exit
    end
  end

  def print_intro
    @io.puts "Welcome to the shop management program!\n"
    @io.puts 'What would you like to do?'
  end

  def print_menu
    @io.puts ' 1 - List all shop items'
    @io.puts ' 2 - Create a new item'
    @io.puts ' 3 - List all orders'
    @io.puts ' 4 - Create a new order'
    @io.puts ' 9 - Exit'
  end

  def list_items
    all_items = @item_repository.all
    all_items.each do |item|
      @io.puts "#{item.id} - #{item.name} - £#{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def list_orders
    all_orders = @order_repository.all
    all_orders.each do |order|
      @io.puts "#{order.id} - Name: #{order.customer_name} - Date: #{order.date_placed} - Items: #{order.items.join(', ')}"
    end
  end

  def create_order
    order_info = new_order_info
    order = Order.new
    order.customer_name, quantity, item_id = order_info
    order.date_placed = Date.today.to_s
    @order_repository.create(order,quantity,item_id)
    another_item?(order)
  end

  def new_order_info
    customer_name = customer_name_input
    item_id = item_name_input_to_id[0]
    quantity = quantity_input
    [customer_name,quantity,item_id]
  end

  def customer_name_input
    customer_name = ''
    until customer_name.match(/^[[:alpha:][:blank:]]+$/) and customer_name.length.positive?
      @io.puts "Please enter your name"
      customer_name = @io.gets.chomp
    end
    customer_name
  end

  def item_name_input_to_id
    item_name = ''
    items = @item_repository.list_of_item_names
    until items.include?(item_name)
      @io.puts "Please enter the name of the item you would like"
      item_name = @io.gets.chomp
    end
    item_id = look_up_item_id(item_name)
    [item_id,item_name]
  end

  def quantity_input
    quantity = ''
    until quantity.match(/^[0-9]*$/) and quantity.to_i.positive?
      @io.puts "How many would you like?"
      quantity = @io.gets.chomp
    end
    quantity.to_i
  end

  def look_up_item_id(name)
    sql = 'SELECT items.id FROM items WHERE items.name = $1'
    params = [name]
    result = DatabaseConnection.exec_params(sql,params)
    result.first['id']
  end

  def another_item?(order)
    @io.puts "Would you like to add anything else to your order? y/n" 
    choice = @io.gets.chomp
    if choice == 'y'
      item_id, item_name = item_name_input_to_id
      quantity = quantity_input
      @order_repository.add_more_items_to_same_order(order,item_name,quantity,item_id)
      another_item?(order)
    elsif choice == 'n' 
      return
    else
      another_item?(order)
    end 
  end

  def create_item
    item_info = new_item_info
    item = Item.new
    item.name, item.unit_price, item.quantity = item_info
    @item_repository.create(item)
  end

  def new_item_info
    name = new_item_name
    unit_price = new_item_unit_price
    quantity = new_item_quantity
    [name,unit_price,quantity]
  end

  def new_item_name
    item_name = ''
    until item_name.match(/^[[:alpha:][:blank:]]+$/) and item_name.length.positive?
      @io.puts "What is the name of the item?"
      item_name = @io.gets.chomp
    end
    item_name
  end

  def new_item_unit_price
    unit_price = ''
    until unit_price.match(/^\d*\.?\d*$/) and unit_price.to_f.positive?
      @io.puts "Please enter the unit price"
      unit_price = @io.gets.chomp
    end
    unit_price
  end

  def new_item_quantity
    quantity = ''
    until quantity.match(/^[0-9]*$/) and quantity.to_i.positive?
      @io.puts "How many do you have in stock?"
      quantity = @io.gets.chomp
    end
    quantity.to_i
  end

end

if __FILE__ == $0
  app = Application.new(
    'orders_items_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
