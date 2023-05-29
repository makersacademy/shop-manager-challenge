require_relative 'lib/database_connection'
require_relative 'lib/orders_repo'
require_relative 'lib/item_repo.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('database_orders')

# Perform a SQL query on the database and get the result set.
order_repository = OrderRepository.new
item_repository = ItemRepository.new

puts <<-TEXT 
 Welcome to the shop management program!
 What do you want to do?
    1 = list all shop items
    2 = create a new item
    3 = list all orders
    4 = create a new order
TEXT

user_input = gets.chomp

case user_input
 when '1' 
    puts "Here is a list of all shop items:"
    item_repository.all.each do |item|
      puts <<-TEXT
      Name: #{item.name}
      Unit Price: #{item.unit_price}
      Quantity: #{item.quantity}
      Order ID: #{item.order_id}

    TEXT
  end 
  
  when '2'
    puts "Create a new item"
    puts "Type name of item:"
    name = gets.chomp
    puts "Type unit price of item:"
    unit_price = gets.chomp
    puts "Type quantity:"
    quantity = gets.chomp

    item_repository.create(name, unit_price, quantity)

  when '3' 
    puts 'Here is a list of all shop orders:'
    order_repository.all.each do |order|
      puts <<-TEXT
      Customer Name: #{order.customer_name}
      Date of Order: #{order.date_of_order}

      TEXT
    end 

  when '4'
    puts 'Create a new order'
    puts "Type customer name:"
    customer_name = gets.chomp
    puts "Type date of order"
    date_of_order = gets.chomp

    order_repository.create(customer_name, date_of_order)
end 

# Print out each record from the result set.

=begin
order_repository.all.each do |order| 
p "Customer #{order.customer_name}, made an order #{order.date_of_order}"
end 

#item_repository.all.each do |item|
#p ""
#end

order = order_repository.find(1)
puts order.customer_name
