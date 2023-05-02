# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('items_orders')

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, name, unit_price, quantity FROM items;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end
# repo = ItemRepository.new
# p repo.all
repo = OrderRepository.new
p repo.find_with_items(1)

