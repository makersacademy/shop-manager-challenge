# file: app.rb
require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('orders')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, item_name, unit_price, quantity, order_id FROM items;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end
sql = 'SELECT id, customer_name, the_date FROM orders'
result1 = DatabaseConnection.exec_params(sql, [])
result1.each do |record|
  p record
end
