# require_relative '../app'

# RSpec.describe Application do

#   def reset_artists_table
#     seed_sql = File.read('spec/seed_shop_manager.sql')
#     connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
#     connection.exec(seed_sql)
#   end

#   before(:each) do
#     reset_artists_table
#   end

 
  
#  # test list(items) method - using doubles

# puts 'Here's a list of all shop items:'
# puts "\n"
# puts '#1 cheese - Unit price: 2 - Quantity: 5'
# puts '#2 hot crossed bus - Unit price: 3 - Quantity: 10'
# puts '#3 sausages - Unit price: 1 - Quantity: 5'
# run_app = Application.new(database, io, repo1, repo2)
# run_app.list('1')

# # test list(orders) method - using doubles

# puts 'Current unfulfilled orders
# puts "\n"
# puts '#1 Joe - order placed: sept'
# puts '#1 Dave - order placed: oct'
# run_app = Application.new(database, io, repo1, repo2)
# run_app.list('3')

# # tests run method

# puts 'Welcome to the shop management program!'
# puts "\n"
# puts 'What do you want to do?'
# puts '1 = list all shop items'
# puts '2 = create a new item'
# puts '3 = list all orders'
# puts '4 = create a new order'
# gets.chomp either 1,2,3,4 or any other key as a string
# run_app = Application.new(database, io, repo1, repo2)
# run_app.run

# # test create(new_item) method

# puts 'Please enter name of new item'
# i_name = gets 'irn bru'
# puts 'Please enter unit price'
# i_price = gets '1'
# puts 'Please enter quantity'
# i_quantity = gets '10'
# puts 'Please enter order number'
# i_order = gets '1'
# puts 'hot crossed bus - Unit price: 1 - Quantity: 10 - added to items'
# # run it
# run_app = Application.new(database, io, repo1, repo2)
# run_app.create(item)

# # create and populate the objects - for integration 
# repo = ItemRepository.new
# item = Item.new
# item.item_name = i_name
# item.price = i_price
# item.quantity = i_quantity
# item.order_id = i_order
# # check it's worked
# items = repo.all
# items.length # => 4
# items[3].item_name  # => i_name
# items[3].price # =>i_price
# items[3].quantity # =>i_quantity
# items[3].order_id # =>i_order

# # test create(new_order) method

# puts 'Please enter customer_name for new order'
# o_name = gets 'Bob'
# puts 'Please enter order date as month'
# o_date = gets 'sept'
# puts 'Bob - order created: sept'
# # run it
# run_app = Application.new(database, io, repo1, repo2)
# run_app.create(order)

# # create and populate the objects - for integration 
# repo = OrderRepository.new
# order = Order.new
# order.customer_name = o_name
# order.date = o_date
# # check it's worked
# orders = repo.all
# orders.length # => 3
# orders[2].customer_name = o_name
# orders[2].date = o_date
 