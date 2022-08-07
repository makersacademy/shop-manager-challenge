require_relative 'lib/database_connection'
require_relative 'lib/item_repo'
require_relative 'lib/order_repo'
require_relative 'lib/item'

class Application
  def initialize(db_name, io, item_repo, order_repo)
    DatabaseConnection.connect('shop_manager')
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo
  end

  def run
    str = "What do you want to do?\n"
    str += "  1 = list all shop items\n  2 = create a new item\n"
    str += "  3 = list all orders\n  4 = create a new order\n"
    @io.puts str

    user = @io.gets.chomp

    if user == "1"
      @io.puts "\nHere's a list of all shop items:\n\n"
      items = @item_repo.all.sort_by { |item| item.id.to_i }
      items.each do |item|
        @io.puts "##{item.id} - #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.qty}"
      end

    elsif user == "2"
      item = Item.new
      @io.puts "\nEnter item name:"
      item.name = @io.gets.chomp
      @io.puts "\nEnter unit price:"
      item.unit_price = @io.gets.chomp
      @io.puts "\nEnter stock quantity:"
      item.qty = @io.gets.chomp
      @io.puts "\n Create item: <#{item.name} - #{item.unit_price} - #{item.qty}>? [Y/n]"
      proceed = @io.gets.chomp
      @item_repo.create(item) if proceed.downcase == "y"
        
    elsif user == "3"
      ord = "\nHere's a list of all orders:\n\n"
      orders = @order_repo.all.sort_by { |order| order.id.to_i }
      orders.each do |order|
        ord += "  ##{order.id} - Customer: #{order.customer_name} - Placed: #{order.date_placed}\n"
        full_order = @order_repo.order_with_items(order.id)
        full_order.items.each do |item|
          ord += "    * #{item.name} - Unit price: #{item.unit_price} - qty: #{item.qty}\n"
        end
      end
      @io.puts ord

    elsif user == "4"
      order = Order.new
      @io.puts "\nWho is ordering?"
      order.customer_name = @io.gets.chomp
      order.date_placed = Time.now.strftime("%d-%b-%y")
      while true
        @io.puts "\nEnter <item name>, <qty> to add to order"
        @io.puts "Type 'Y' when done"
        user = @io.gets.chomp
        break if user.downcase == "y"
        new_item = Item.new
        new_item.name = user.split(",")[0].strip
        new_item.qty = user.split(",")[1].strip
  
        #horrific
        @item_repo.all.each do |item|
          new_item.id = item.id if item.name == new_item.name
        end

        @io.puts "Add <#{new_item.name} - #{new_item.qty}> to order? [Y/n]"
        user = @io.gets.chomp
        order.items << new_item if user.downcase == "y"
      end
      @io.puts "\nOrder summary:"
      order.items.each do |item|
        @io.puts "* #{item.name} - qty: #{item.qty}"
      end
      @io.puts "\nProceed? [Y/n]"
      user = @io.gets.chomp
      if user.downcase == "y"
        @order_repo.create(order) 
        @io.puts "\nOrder placed!"
      else
        @io.puts "\nOrder cancelled!"
      end
    end
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