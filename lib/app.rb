# file: app.rb

require_relative 'database_connection'
require_relative 'item_repository'

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
    @terminal.puts "Here's a list of shop items"
    results = ItemRepository.new
    results.all.each do |record|
      puts "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
    end
  end

  # def menu_1
  #   @t_menu1.puts "Here's a list of shop items"
  #   results = ItemRepository.new
  #   results.all.each do |record|
  #     puts "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
  #   end
  # end

  def run_menu
    @terminal.puts "Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    
    menu_choice = @terminal.gets
  
    # if menu_choice == "1"
    #   menu_1
    # elsif menu_choice == "2"
    #   puts "Let's create a new item."
    #   puts "What is the item name?"
    #   item_name = gets.chomp

    #   post_results = ItemRepository.new
    #   post_results.all.each do |post|
    #     puts "#{post.id} - #{post.title} - #{post.content} - #{post.views}"
      # end
    # end
  end
end

