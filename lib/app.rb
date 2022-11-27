# file: app.rb

require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'item'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_test')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, item_name, unit_price, quantity FROM items;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
class Menu
  def initialize(terminal)
    @terminal = terminal
  end

  def menu_1
    # puts "Here's a list of shop items"
    @terminal.puts "Here's a list of shop items"
    results = ItemRepository.new
    results.all.each do |record|
      puts "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
    end
  end

  def menu_2
    @terminal.puts "Let's create a new item!\nEnter a name for this item"
    results = ItemRepository.new
    item = Item.new
    item.item_name = @terminal.gets
    @terminal.puts "Enter a price for this item"
    item.unit_price = @terminal.gets
    @terminal.puts "Enter a quantity for this item"
    item.quantity = @terminal.gets

    results.create(item)
  end

  def menu_3 
    @terminal.puts "Here's a list of orders"
    results = OrderRepository.new
    results.all.each do |record|
      puts "#{record.id} - #{record.date} - #{record.customer_name} - #{record.item_id} - #{record.quantity}"
    end
  end

  def run_menu
    @terminal.puts "Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    
    menu_choice = @terminal.gets.chomp
    if menu_choice == "1"
      self.menu_1
    elsif menu_choice == "2"
      self.menu_2
    elsif menu_choice == "3"
      self.menu_3
    end
  end
  # def choose_menu(run_menu)
  #   if run_menu == "1"
  #     self.menu_1
  #   end
  # end
end

# menu = Menu.new
# menu.choose_menu(menu.run_menu)