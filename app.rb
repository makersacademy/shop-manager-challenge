require_relative "lib/database_connection"
require_relative "lib/order_repository"
require_relative "lib/item_repository"
require_relative "./app_private_methods"

class Application

  include PrivateMethods

  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    _show "Welcome to the shop management program!"
    _show "What would you like to manage?"
    _show " 1 - Orders"
    _show " 2 - Items"
    user_choice = _prompt("(Enter the number corresponding to your choice)").to_i
    if user_choice == 1
      @io.puts "Orders Manager"
      option_selected = _prompt_for_main_options("order")
    elsif user_choice == 2
      @io.puts "Items Manager"
      option_selected = _prompt_for_main_options("item")
    end

    if option_selected == 1
      _all_method_for_OrderRepository
    elsif option_selected == 2
      _find_method_for_OrderRepository
    elsif option_selected == 3
      _create_method_for_OrderRepository
    elsif option_selected == 4
      _show "Which order?"
      id = _prompt "(Enter the order ID)"
      order = @order_repository.find(id)
      attribute_to_update = _prompt_for_update_options
      _update_method_for_OrderRepository(order, attribute_to_update)
    elsif option_selected == 5
      _show "Which order?"
      order_id = _prompt "(Enter the order ID)"
      @order_repository.delete(order_id)
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_database',
    Kernel,
    OrderRepository.new,
    ItemRepository.new
  )
  app.run
end

# p Kernel.methods.sort
# app = Application.new(
#       'shop_database',
#       Kernel,
#       OrderRepository.new,
#       ItemRepository.new
#     )

#     p app.send(:_prompt_for_options, "order")

# p app.method(:_prompt_for_options).receiver

# p PrivateMethods.ancestors
# p Application.ancestors