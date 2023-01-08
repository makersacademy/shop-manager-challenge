require 'pg'

require_relative 'lib/database_connection'
require_relative 'lib/item'
require_relative 'lib/item_repository'
require_relative 'lib/order'
require_relative 'lib/order_repository'



class App
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def view_items
    items = @item_repository.all
    items.each do |item|
      @io.puts "id: #{item.id}, name: #{item.item_name}, unit price: #{item.unit_price}, qty: #{item.quantity}"
    end
  end 

  def view_orders
    orders = @order_repository.all
    orders.each do |order|
      @io.puts "id: #{order.id}, name: #{order.customer_name}, order date: #{order.order_date}, item_id: #{order.item_id}"
    end
  end 

  def add_item
    item = Item.new
    @io.puts "Enter item name: "
    item.item_name = @io.gets.chomp
    @io.puts "Enter item price: "
    item.unit_price = @io.gets.chomp
    @io.puts "Enter item quantity: "
    item.quantity = @io.gets.chomp
    @item_repository.create(item)
  end 

  def add_order
    order = Order.new
    @io.puts "Enter customer name: "
    order.customer_name = @io.gets.chomp
    @io.puts "Enter order date: "
    order.order_date = @io.gets.chomp
    @io.puts "Enter item_id: "
    order.item_id = @io.gets.chomp
    @order_repository.create(order)
  end 

  def update_item_name
    
    @io.puts "Enter item id: "
    id = @io.gets.chomp.to_i

    @io.puts "Enter new item name: "
    new_name = @io.gets.chomp
    @io.puts "Item updated"
    @item_repository.update_item_name(new_name, id)
  end 

  def update_item_price
    @io.puts "Enter item id: "
    id = @io.gets.chomp.to_i

    @io.puts "Enter new item price: "
    new_unit_price = @io.gets.chomp.to_i
    @io.puts "Item updated"
    @item_repository.update_unit_price(new_unit_price, id)
    
  end 

  def update_item_quantity
    @io.puts "Enter item id: "
    id = @io.gets.chomp.to_i

    @io.puts "Enter new item quantity: "
    new_unit_quantity = @io.gets.chomp.to_i
    @io.puts "Item updated"
    @item_repository.update_item_quantity(new_unit_quantity, id)
  end

  def display_menu
    @io.puts "Shop Manager................"   
    @io.puts "    [1]  view all items "           
    @io.puts "    [2]  view all orders"
    @io.puts "    [3]  add new item"
    @io.puts "    [4]  add new order"
    @io.puts "    [5]  update item name"  
    @io.puts "    [6]  update item price"
    @io.puts "    [7]  update item quantity"   
   

    @io.puts "............................."
      
    @io.puts " Select an option[ ]"
    selected_option = @io.gets.chomp
    if selected_option == '1'
          then view_items
    elsif selected_option == '2'
          then view_orders
    elsif selected_option == '3'
          then add_item
    elsif selected_option == '4'
          then add_order
    elsif selected_option == '5'
          then update_item_name
    elsif selected_option == '6'
          then update_item_price
    elsif selected_option == '7'
      then update_item_quantity
    end
  end 
 
end 

