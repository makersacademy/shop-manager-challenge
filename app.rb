require_relative "lib/database_connection"
require_relative "lib/items_repository"
require_relative "lib/orders_repository"
require_relative "lib/orders"
require_relative "lib/items"
DatabaseConnection.connect("shop_manager_test")

repo = OrdersRepository.new

repo.all.each do |record|
  puts "Customer name: #{record.customer_name} - Date ordered: #{record.date} - Item: #{record.items.first.name} - Price: £#{record.items.first.price}"
end
