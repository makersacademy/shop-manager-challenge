require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager_2_test')

# Perform a SQL query on the database and get the result set.
items = 'SELECT name, price, quantity FROM items;'
items_result = DatabaseConnection.exec_params(items, [])

orders = 'SELECT customer_name, date, item_id FROM orders;'
orders_result = DatabaseConnection.exec_params(orders, [])

# Print out each record from the result set .
items_result.each do |record|
  p record
end

orders_result.each do |record|
    p record
  end