require_relative 'lib/database_connection'
require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager_2_test')

# Perform a SQL query on the database and get the result set.
items = 'SELECT name, price, quantity FROM items;'
items_result = DatabaseConnection.exec_params(items, [])

orders = 'SELECT customer_name, date, item_id FROM orders;'
orders_result = DatabaseConnection.exec_params(orders, [])

# test = ItemRepository.new
# p test.all
# item = Item.new
# item.name = 'phone'
# item.price = '120.00'
# item.quantity = 100
# test.create(item)
# p test.all

items = ItemRepository.new
orders = OrderRepository.new



# Print out each record from the result set .
# items_result.each do |record|
#   p record
# end

# orders_result.each do |record|
#     p record
#   end
while true do
    puts 'Welcome to the shop management program!'

    puts 'What do you want to do?'
    puts '1 - list all shop items'
    puts '2 - create a new item'
    puts '3 - list all orders'
    puts '4 - create a new order'

    choice = gets.chomp

    case choice
    when '1'
        items.all.each do |item|
            puts "item: #{item['name']}, price: #{item['price']}, quantity: #{item['quantity']}"
        end

    when '2'
        new_item = Item.new
        puts 'please enter item name'
        new_item.name = gets.chomp
        puts 'please enter a price'
        new_item.price = gets.chomp
        puts 'please enter a quantity'
        new_item.quantity = gets.chomp
        items.create(new_item)
    end

end