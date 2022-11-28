# file: app.rb

require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'item'
require_relative 'order_repository'
require_relative 'order'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_test')

class Menu
  # def initialize(terminal)
  #   @terminal = terminal
  # end

  def menu_1
    puts "Here's a list of shop items"
    results = ItemRepository.new
    results.all.each do |record|
      puts "##{record.id} - #{record.item_name} - Unit price: #{record.unit_price} - Quantity: #{record.quantity}"
    end
  end

  def menu_2
    puts "Let's create a new item!\nEnter a name for this item"
    results = ItemRepository.new
    item = Item.new
    item.item_name = gets
    puts "Enter a price for this item"
    item.unit_price = gets
    puts "Enter a quantity for this item"
    item.quantity = gets

    results.create(item)
  end

  def menu_3 
    puts "Here's a list of orders"
    results = OrderRepository.new
    results.all.each do |record|
      puts "##{record.id} - #{record.date} - #{record.customer_name} - Item_id: #{record.item_id} - Quantity: #{record.quantity}"
    end
  end

  def menu_4
    puts "Let's create a new order!\nEnter a date for this order"
    results = OrderRepository.new
    order = Order.new
    order.date = gets
    puts "Enter a customer name for this order"
    order.customer_name = gets
    puts "Enter an item id for this order"
    order.item_id = gets
    puts "Enter a quantity for this order"
    order.quantity = gets

    results.create(order)
  end

  def run_menu
    puts "Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    
    menu_choice = gets.chomp
    if menu_choice == "1"
      self.menu_1
    elsif menu_choice == "2"
      self.menu_2
    elsif menu_choice == "3"
      self.menu_3
    elsif menu_choice == "4"
      self.menu_4
    end
  end
  # def choose_menu(run_menu)
  #   if run_menu == "1"
  #     self.menu_1
  #   end
  # end
end

menu = Menu.new
menu.choose_menu(menu.run_menu)