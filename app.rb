# file: app.rb
require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

# Checking the database connects to both tables on the database

# sql = 'SELECT id, customer_name, order_date FROM orders;'
sql = 'SELECT id, item_name, price, order_id FROM items;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end
