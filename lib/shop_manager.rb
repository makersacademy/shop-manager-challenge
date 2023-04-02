require_relative './item'
require_relative './order'
require 'pg'

class ShopManager
  WHAT_TO_DO = 'What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order'

  def initialize
    db_connect
    initiate_menu
  end

  def initiate_menu(initial = true)
    puts "
    Welcome to the shop management program!
    " if initial == true
    puts "
    #{WHAT_TO_DO}
    "
    answer = gets.chomp
    case answer
    when '1'
      print_all_items(all_items)
    when '2'
      new_item_collect_data
    when '3'
      all_orders
    when '4'
      new_order_collect_data
    else
      initiate_menu(false)
    end
  end

  def new_item_collect_data
    while true do
      puts 'Enter the name for the new Item'
      name = gets.chomp
      break if name.count("a-zA-Z") > 0
    end
    while true do
      puts "Enter the price for the #{name}"
      unit_price = gets.chomp
      break if unit_price.to_i.is_a? Integer
    end
    while true do
      puts "Enter the quantity for the #{name}"
      quantity = gets.chomp
      break if quantity.to_i.is_a? Integer
    end
    item = Item.new(name, unit_price, quantity)
    new_item(item)
  end

  def new_item(item)
    # add item to items table
    query = "INSERT INTO items(name, unit_price, quantity) 
    VALUES('#{item.name}', #{item.unit_price.to_i}, #{item.quantity.to_i});"
    result = @conn_db.exec(query)
    puts "Your item has been added succesfully"
  end

  def db_connect()
    @conn_db = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  end

  def new_order_collect_data
    while true do
      puts 'New Order, please enter your name'
      customer_name = gets.chomp
      break if customer_name.count("a-zA-Z") > 4 && customer_name.split(' ').count >= 2
    end
    items = all_items
    while true do
      puts "Please select you item's id"
      item_id = gets.chomp
      if item_id.to_i.is_a? Integer
        return_item = items.find { |curr_item| curr_item.item_id == item_id }
        if !return_item.nil?
          item = Item.new(return_item.name, return_item.unit_price, return_item.quantity, return_item.item_id)
          order = Order.new(customer_name, item)
          new_order(order)
        end
      end
      break unless return_item.nil?
    end
  end

  def new_order(order)
    # add order to orders table
    query = "INSERT INTO orders(customer_name, item_id) 
    VALUES('#{order.customer_name}', '#{order.item.item_id}') RETURNING *;"
    @conn_db.exec(query)
    puts "Your order has been placed succesfully, thank you!"
  end

  private
  def get_select_query(table)
    "SELECT * FROM #{table};"
  end

  def all_items
    query = get_select_query('items')
    items = @conn_db.exec(query)
    items = items.map do |item|
      Item.new(item['name'], item['unit_price'], item['quantity'], item['item_id'])
    end

    items
  end

  def orders_all
    query = get_select_query('orders')
    @conn_db.exec(query)
  end

  def all_orders
    items = all_items
    orders = orders_all
    orders = orders.map do |order|
      item = items.find { |curr_item| curr_item.item_id == order['item_id'] }
      Order.new(order["customer_name"], item, order["order_id"])
    end
    print_all_orders(orders)
  end

  def print_all_items(items)
    #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
    items.each do |item|
      puts "Item id: #{item.item_id} - #{item.name} - Unit price: £#{item.unit_price}.00 - Quantity: #{item.quantity}"
    end
  end

  def print_all_orders(orders)
    #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
    orders.each do |order|
      puts "Order id: #{order.order_id} - #{order.customer_name} - Item: #{order.item.name} - Price: £#{order.item.unit_price}.00"
    end
  end
end

ShopManager.new

