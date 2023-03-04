require_relative "lib/database_connection"
require_relative "lib/order_repository"
require_relative "lib/item_repository"

DatabaseConnection.connect("shop_database_test")
orders = OrderRepository.new
items = ItemRepository.new

item5 = items.find(5)
p item5

order6 = Order.new
order6.date = "2023-03-03"
order6.customer = "Jones"
order6.items = [item5]

orders.create(order6)
p items.all
p item5_update = items.find(2)
p item5_update = items.find(3)
p item5_update = items.find(5)









# class Application

#   def initialize(database_name, io, order_repository, item_repository)
#     DatabaseConnection.connect(database_name)
#     @io = io
#     @order_repository = order_repository
#     @item_repository = item_repository
#   end

#   def run
    
     
#   end
# end

# if __FILE__ == $0
#   app = Application.new(
#     'shop_database_test',
#     Kernel,
#     OrderRepository.new,
#     ItemRepository.new
#   )
#   app.run
# end