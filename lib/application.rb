require_relative './item'
require_relative './item_repository'
require_relative './order'
require_relative './order_repository'
require_relative './database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def print_all_items
    result = @item_repository.all_items
    result.each do |item|
      @io.puts "##{item.id} - #{item.name} - Price: #{item.price} - Stock quantiy: #{item.stock_qty}"
    end
  end

  def create_new_item
    item = Item.new

    @io.puts "Enter item name:"
    item.name = @io.gets.chomp
    @io.puts "Enter item price:"
    item.price = @io.gets.chomp
    @io.puts "Enter item stock quantity:"
    item.stock_qty = @io.gets.chomp

    @item_repository.create_item(item)
    @io.puts "Item created."    
  end

  def print_all_orders
    result = @order_repository.all_orders
    result.each do |order|
      @io.puts "##{order.id} - Customer: #{order.customer} - Item: #{order.item} - Order date: #{order.date}"
    end
  end



end