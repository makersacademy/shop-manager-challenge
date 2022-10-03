require_relative 'lib/database_connection'

DatabaseConnection.connect('shop_manager')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p record
end