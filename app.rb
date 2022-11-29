require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT item_name, quantity, order_no FROM stocks;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  puts record
end