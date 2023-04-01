# file: app.rb

require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('shop_manager')


# create order


order.items.each do |item| # items is an array of Item objects
  join_sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
  join_params = [item.id, order.id]

  DatabaseConnection.exec_params(join_sql, join_params)
end
