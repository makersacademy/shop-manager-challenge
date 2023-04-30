require_relative 'item_repository'
require_relative 'order_repository'
require_relative 'database_connection'

class Application

  def initialize(database_name = 'shop_manager', io = Kernel, item_repository = ItemRepository.new, order_repository = OrderRepository.new)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    print_welcome
    print_ask_for_input
    print_menu
    process(@io.gets.chomp)
  end

  def process(input)
    case input
    when '1'
      puts_formatted_item_list
    when '2'
      create_item
    when '3'
      puts_formatted_order_list
    when '4'
      create_order
    when '5'
      assign_item_to_order
    when '6'
      exit
    end 
  end

  def puts_formatted_item_list
    formatted_string = ""
    @item_repository.all.each_with_index do |item, i|
      item_string = "#{i+1} #{item.name} - Unit price: #{item.price} - Quantity: #{item.quantity}\n"
      formatted_string << item_string
    end
    @io.puts formatted_string
  end

  def create_item
    new_item = Item.new

    new_item.name, new_item.price, new_item.quantity = get_item_attribute_inputs 
    
    @item_repository.create(new_item)
  end

  def puts_formatted_order_list
    formatted_string = ""
    @order_repository.all.each_with_index do |order, i|
      order_string = "#{i+1} - Customer name: #{order.customer_name}  - Order date: #{order.order_date} Items:#{list_items_in_order(order)} \n"
      formatted_string << order_string
    end

    @io.puts formatted_string
  end

  def create_order
    new_order = Order.new

    new_order.customer_name, new_order.order_date = get_order_attribute_inputs

    @order_repository.create(new_order)
  end

  def assign_item_to_order
    @io.print "\nWhich order would you like to add to? [Input order #]: "
    order_id = @io.gets.chomp.to_i
    @io.print "\nWhich item would you like to add? [Input item #]: "
    item_id = @io.gets.chomp.to_i

  end

  private 

  def print_welcome
    @io.puts 'Welcome to the shop management program!'
  end

  def print_ask_for_input
    @io.puts "\nWhat do you want to do?"
  end

  def print_menu
    @io.puts '1 = list all shop items'
    @io.puts '2 = create a new item'
    @io.puts '3 = list all order'
    @io.puts '4 = create a new order'
    @io.puts '5 = assign an item to an order'
    @io.puts '6 = exit'
  end

  
  def get_item_attribute_inputs
    @io.print "\nPlease type the item's name?: "
    name = @io.gets.chomp
    @io.print "\nPlease type the item's price?: "
    price = @io.gets.chomp.to_i
    @io.print "\nPlease type the item's quantity?: "
    quantity = @io.gets.chomp.to_i

    return name, price, quantity
  end

  def get_order_attribute_inputs
    @io.print "\nPlease type the customer's name?: "
    customer_name = @io.gets.chomp
    @io.print "\nPlease type the order date [format: YYYY-MM-DD]?: "
    order_date = @io.gets.chomp

    return customer_name, order_date
  end
  
  def list_items_in_order(order)
    return "" if @item_repository.find_by_order(order.id).nil?
    string = []
    @item_repository.find_by_order(order.id).each do |item|
      item_name = " #{item.name}"
      string << item_name
    end

    string.join(",")
  end

end