require_relative './lib/database_connection'
require_relative './lib/order_repository'
require_relative './lib/item_repository'

class Application
  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What do you want to do?'
    @io.puts user_menu
    @user_input = @io.gets.chomp

    return user_output
  end

  def user_menu
    ['1 = list all shop items',
    '2 = create a new item',
    '3 = list all orders',
    '4 = create a new order']
  end

  def user_output
    if @user_input == '1'
      @io.puts 'Here is a list with all shop items'
      @item_repository.all.each do |item|
        @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    elsif @user_input == '2'
      return create_item
    elsif @user_input == '3'
      @io.puts 'Here is a list with all orders'
      @order_repository.all.each do |order|
        @io.puts "##{order.id} #{order.customer} - #{order.date}"
      end
    elsif @user_input == '4'

    end
  end

  def create_item
    item = Item.new
    @io.puts "What is the name of the item?"
    name = @io.gets.chomp
    item.name = name
    @io.puts "What is the price of the item?"
    price = @io.gets.chomp
    item.unit_price = price
    @io.puts "What is the quantity of the item?"
    quantity = @io.gets.chomp
    item.quantity = quantity
    @item_repository.create(item)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end