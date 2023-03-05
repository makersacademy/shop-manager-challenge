require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'
require_relative 'lib/menu_result'
require_relative 'lib/menu'

DatabaseConnection.connect('shop_manager')


menu = Menu.new(Kernel)
menu_result = MenuResult.new(Kernel)

menu.show_menu
result = menu.get_result
if result == '1'
  menu_result.list_items
elsif result == '2'
  menu_result.create_item
elsif result == '3'
  menu_result.list_orders
else
  menu_result.create_order
end




