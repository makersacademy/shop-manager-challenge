require_relative 'lib/database_connection'
require_relative 'lib/item_repository.rb'
require_relative 'lib/order_repository.rb'
require_relative 'lib/order.rb'
require_relative 'lib/item.rb'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    welcome_user
    print_interface
    user_selection(@io.gets.chomp)
    exit
  end

  def welcome_user
    @io.puts "Welcome to the shop management program!"
  end

  def print_interface
    @io.puts "What do you want to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
  end

  def user_selection(user_input)
    case user_input
    when "1"
      print_all_items
    when "2"
      create_new_item
    when "3"
      print_all_orders
    when "4"
      create_new_order
    else
      @io.puts "Sorry I do not understand, please enter a number 1 to 4"
    end
  end

  def print_all_items
    @item_repository.all.each do |item|
      @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def create_new_item
    new_item = Item.new
    new_item_name(new_item)
    new_item_unit_price(new_item)
    new_item_quantity(new_item)
    return @item_repository.create(new_item)
  end

  def print_all_orders
    @order_repository.all.each do |order|
      @io.puts "##{order.id} #{order.customer_name} - Date ordered: #{order.date_order_placed} - Item Id: #{order.item_id}"
    end
  end

  def create_new_order
    new_order = Order.new
    new_order_customer_name(new_order)
    check_date_format(new_order)
    new_order_product_id(new_order)
    return @order_repository.create(new_order)
  end

  def new_order_product_id(new_order)
    @io.puts "Please enter the item id that has been ordered"
    loop do 
      item = @io.gets.chomp
      if all_items_ids.include?(item)
        new_order.item_id = "#{item}"
        @io.puts "Thank you for sumbitting a new item"
        break
      else
        @io.puts "Sorry the ID is not recognised, please re-enter the product ID"
      end
    end
  end

  def new_order_date_placed(new_order)
    @io.puts "Please enter the date the order was placed (YYYY-MM-DD formatt)"
    date = @io.gets.chomp
    new_order.date_order_placed = "#{date}"
  end

  def check_date_format(new_order)
    @io.puts "Please enter the date the order was placed (YYYY-MM-DD formatt) "
    loop do 
      user_input = @io.gets.chomp.split("")
      if user_input[4] != "-" || user_input[7] != "-" 
        @io.puts "Sorry the date is in the incorrect formatt - please enter the date using YYYY-MM-DD formatt"
      elsif is_numeric?(user_input.join.delete("-")) == false
        @io.puts "Sorry the date was not submitted using numbers, please re-enter the date using integers"
      elsif user_input[0..3].join.to_i < 2020 || user_input[0..3].join.to_i > 2022
        @io.puts "The year inputted is unsuitable - please enter a year from 2000 - 2022"
      elsif user_input[5..6].join.to_i < 1 || user_input[5..6].join.to_i > 12
        @io.puts "The month is not recognised - please enter a month from 1 (Janurary) to 12 (December)"
      elsif user_input[8..9].join.to_i < 1 || user_input[8..9].join.to_i > 31
        @io.puts "That date does not exist, please ensure the date is between the 1st and 31st"
      else
        p user_input
        new_order.date_order_placed = "#{user_input.join}"
        break
      end
    end
  end

  def new_order_customer_name(new_order)
    @io.puts "Please enter the customer name of the new order"
    customer = @io.gets.chomp
    new_order.customer_name = "#{customer}"
  end

  def new_item_name(new_item)
    @io.puts "Please enter the name of the new item"
    name = @io.gets.chomp
    new_item.name = "#{name}"
  end

  def new_item_unit_price(new_item)
    @io.puts "Please enter the unit price of the new item"
    loop do
      price = @io.gets.chomp
      if is_numeric?(price)
        new_item.unit_price = "#{price}"
        break
      else
        @io.puts "Sorry that was unable to be submitted, please enter the unit price as a number"
      end
    end
  end 

  def new_item_quantity(new_item)
    @io.puts "Please enter the quantity of the new item"
    loop do 
      quantity = @io.gets.chomp
      if is_numeric?(quantity)
        new_item.quantity = "#{quantity}"
        @io.puts "Thank you for sumbitting a new item"
        break
      else 
        @io.puts "Sorry that was unable to be submitted, please enter the quantity as a number"
      end
    end
  end
  
  private 

  def all_items_ids
    return @item_repository.all.map do |item|
      item.id
    end
  end

  def is_numeric?(n)
    n.to_i.to_s == n ? true : false
  end

  if __FILE__ == $0
  app = Application.new(
    'shop_manager_test',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
  end 
end


#item_repository = ItemRepository.new
#order_repository = OrderRepository.new
#database_name = 'shop_manager_test'
#runny = Application.new(database_name, Kernel, item_repository, order_repository)
#runny.run
