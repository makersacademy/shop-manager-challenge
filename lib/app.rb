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
  def initialize(io)
    @io = io
  end

  def run_menu
    @io.puts "Welcome to the shop management program!\n\nWhat would you like to do? (type a number)\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order"
    
    menu_choice = @io.gets
  
    if menu_choice == "1"
      results = ItemRepository.new
      results.all.each do |record|
        puts "#{record.id} - #{record.item_name} - #{record.unit_price} - #{record.quantity}"
      end
    # elsif menu_choice == "2"
    #   post_results = PostRepository.new
    #   post_results.all.each do |post|
    #     puts "#{post.id} - #{post.title} - #{post.content} - #{post.views}"
      # end
    end
  end
end

