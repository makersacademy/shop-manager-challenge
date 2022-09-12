require '../lib/database_connection'

require '../lib/order_repository'
require '../lib/order'
require '../lib/item_repository'
require '../lib/item'

DatabaseConnection.connect('shop_manager_library')

orders = OrderRepository.new(Kernel)
items = ItemRepository.new(Kernel)

def interactive_menu
    loop do
        puts "What would you like to do?"
        puts ("1. List all items")
        puts ("2. create new item")
        puts ("3. List all orders")
        puts ("4. create new order")
        puts ("9. Exit")
        answer = gets.chomp
        case answer
        when '1'
            items.all
        when '2'
            items.create
        when '3'
            orders.all
        when '4'
            orders.create
        when '9'
            exit
        else
            "Invalid selection"
        end
    end
end

interactive_menu


