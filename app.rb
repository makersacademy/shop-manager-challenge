# file: app.rb

require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_test')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, item, price, quantity FROM items;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end