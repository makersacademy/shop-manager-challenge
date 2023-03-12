require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'


DatabaseConnection.connect('shop_manager')

item_repository = ItemRepository.new
order_repository = OrderRepository.new

# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |record|
#   p record
# end

# item = item_repository.find(1)
# puts item.name

