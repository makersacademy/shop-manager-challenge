require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')


# Print out each record from the result set .
result.each do |record|
  p record
end