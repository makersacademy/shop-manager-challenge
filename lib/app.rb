# file: app.rb

require_relative 'database_connection'
require 'item_repository'
require 'order_repository'
require 'order'

class Application
  def initialize(database_name, io)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = ItemRepository.new
    @order_repository = OrderRepository.new
    @item = Item.new
    @order = Order.new
  end

  def run
    @io.puts('Welcome to the shop management program!')
    @io.puts('What do you want to do?')
    @io.puts('1 = list all shop items 2 = create a new item 3 = list all orders 4 = create a new order')
    choice = @io.gets.chomp
    result = ""
    
    if choice == '1'
      @item_repository.all.each do |item| result << "#{item.id}. #{item.item_name} #{item.unit_price}, #{item.quantity}. \n" end
      return result

    elsif choice == '2'
      @io.puts('List the following parameters of the item separated by comma: name, price, quantity.')
      #the new item will be a comma separated string with the parameters of the new item
      new_item_params = @io.gets.chomp.split(", ")
      @item.item_name = new_item_params[0]
      @item.unit_price = new_item_params[1]
      @item.quantity = new_item_params[2]

      @item_repository.create(@item)
      
    elsif choice == '3'
      @order_repository.all.each do |order| result << "#{order.id}. #{order.customer_name} - #{order.date}.\n" end
      return result

    elsif choice == '4'
      @io.puts('List the following parameters of the new order separated by a comma: customer name, date.')
      new_order_params = @io.gets.chomp.split(", ")
      @order.customer_name = new_order_params[0]
      @order.date = new_order_params[1]

      @order_repository.create(@order)
    end

  end
end

# We need to give the database name to the method `connect`.