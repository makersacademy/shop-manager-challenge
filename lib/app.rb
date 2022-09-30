require '../lib/database_connection'
require '../lib/order_repository'
require '../lib/order'
require '../lib/item_repository'
require '../lib/item'

DatabaseConnection.connect('shop_manager_library')

class UserInterface
  def initialize(io, orders, items)
    @io = io
    @orders = orders
    @items = items
    @quantities = []
  end

  def prompt(message)
    @io.puts(message)
    return @io.gets.chomp
  end

  def stock_check(item_id)
    @items.stock_level(item_id).to_i
  end

  def item_name(item_id)
    return @items.find_name(item_id)
  end

  def incorrect_selection
    @io.puts "Incorrect selection"
  end

  def quantity_calculator
    counter = 1
    @items.amount.times do
      @quantities << [counter, stock_check(counter)]
      counter += 1
    end
  end

  def quantity_check(item_id, quantity)
    result = true
    @quantities.each do |item|
      item[0] == item_id && item[1] -= quantity.to_i < 0
      result = false
    end
    return result
  end
      
  def item_selector
    items_array = []
    loop do
      quantity_calculator
      @items.view_items
      item = prompt 'Select an item id to add to your order or type exit to exit'
      return incorrect_selection if !(1..@items.amount).include?(item.to_i)
      quantity = prompt 'How many of this item?'
      return incorrect_selection if quantity_check(item.to_i, quantity.to_i) == false
      @io.puts "#{quantity} of item #{item_name(item.to_i)} ordered"
      if quantity.to_i > 1
        quantity.to_i.times do
          items_array << item.to_i
        end
      else
        items_array << item.to_i
      end
    end
    return items_array
  end

  def create_order
    name = prompt "What is your name?"
    items = item_selector
    return "Order not created!" if items.nil?
    @orders.create_order(name, items)
    @io.puts "Order created! Thanks, #{name}!"
    @io.puts "Here is the new order list:"
    @orders.view_orders
  end

  def create_item
    name = prompt "What is the name of the item you'd like to add?"
    price = prompt "How much does each unit cost?"
    return incorrect_selection if price.to_i <= 0
    stock = prompt "How many are you putting in stock?"
    return incorrect_selection if stock.to_i <= 0
    @items.create(name, price.to_i, stock.to_i)
    @io.puts "Item created: #{name}, unit price: $#{price} with #{stock} in stock. Thanks!"
    @io.puts "Here is the new item list:"
    @items.view_items
  end

  def interactive_menu
    loop do
      @io.puts "What would you like to do?\n1. View Orders\n2. Create Order\n3. View Items\n4. Create Item\n9. Exit"
        result = @io.gets.chomp
      case result
      when "1"
        @orders.view_orders
      when "2"
        create_order
      when "3"
        @items.view_items
      when "4"
        create_item
      when "9"
        exit
      else
        incorrect_selection
      end
    end
  end
end

orders = OrderRepository.new
items = ItemRepository.new
interface = UserInterface.new(Kernel, orders, items)

interface.interactive_menu