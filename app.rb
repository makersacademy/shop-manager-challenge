require_relative 'lib/database_connection'
require_relative 'lib/item_repo'
require_relative 'lib/order_repo'
require_relative 'lib/item'

class Application
  def initialize(db_name, io, item_repo, order_repo)
    DatabaseConnection.connect(db_name)
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo
  end

  def all_items
    @io.puts "\nHere's a list of all shop items:\n\n"
    items = @item_repo.all.sort_by { |item| item.id.to_i }
    items.each do |item|
      @io.puts "##{item.id} - #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.qty}"
    end
  end

  def ask_respond(text, text_2 = nil)
    @io.puts text
    @io.puts text_2 if text_2 != nil
    @io.gets.chomp
  end

  def proceed(item)
    str = "\n Create item: <#{item.name} - #{item.unit_price} - #{item.qty}>? [Y/n]"
    proceed = ask_respond(str)
    @item_repo.create(item) if proceed.downcase == "y"
  end

  def new_item
    item = Item.new
    item.name = ask_respond("\nEnter item name:")
    item.unit_price = ask_respond("\nEnter unit price:")
    item.qty = ask_respond("\nEnter stock quantity:")
    proceed(item)
  end
  
  def all_orders
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
  end

  def make_item
    user = ask_respond("\nEnter <item name>, <qty> to add to order", "Type 'Y' when done")
    return false if user.downcase == "y"

    # ***problem here if user enters nothing!***
    new_item = Item.new
    new_item.name = user.split(",")[0].strip
    new_item.qty = user.split(",")[1].strip
    new_item.id = @item_repo.find_by_name(new_item.name).id
    new_item  
  end

  def order_summary(order)
    @io.puts "\nOrder summary:"
    order.items.each { |item| @io.puts "* #{item.name} - qty: #{item.qty}" }
    ask_respond("\nProceed? [Y/n]")
  end

  def place_order(order, proceed)
    if proceed.downcase == "y"
      @order_repo.create(order) 
      @io.puts "\nOrder placed!"
    else
      @io.puts "\nOrder cancelled!"
    end
  end

  def create_order
    order = Order.new
    order.customer_name = ask_respond("\nWho is ordering?")
    order.date_placed = Time.now.strftime("%d-%b-%y")
    order
  end
  
  def new_order
    order = create_order()
    while true
      new_item = make_item()
      break if new_item == false

      user = ask_respond("Add <#{new_item.name} - #{new_item.qty}> to order? [Y/n]")
      order.items << new_item if user.downcase == "y"
    end
    basket = order_summary(order)
    place_order(order, basket)
  end

  def run_menu
    str = "What do you want to do?\n"
    str += "  1 = list all shop items\n  2 = create a new item\n"
    str += "  3 = list all orders\n  4 = create a new order\n"
    ask_respond(str)
  end

  def run 
    user = run_menu
    all_items() if user == "1"
    new_item() if user == "2"
    all_orders() if user == "3"
    new_order() if user == "4"
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
