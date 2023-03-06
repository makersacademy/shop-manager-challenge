require_relative "lib/database_connection"
require_relative "lib/order_repository"
require_relative "lib/item_repository"
require_relative "./app_modules/order_manager_module"
require_relative "./app_modules/item_manager_module"

class Application

  include OrderManager
  include ItemManager

  def initialize(database_name, io, order_repository, item_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @order_repository = order_repository
    @item_repository = item_repository
  end

  def run
    _show "---------------------------------------"
    _show "WELCOME TO THE SHOP MANAGEMENT PROGRAM!"
    _show "---------------------------------------"
    _show "What would you like to manage?"
    _show " 1 - Orders"
    _show " 2 - Items"
    user_choice = _order_or_item?
    _show_main_menu_for(user_choice)
  end

  private 

  def _order_or_item?
    while true
      orders_or_items = _prompt.to_i
      return "order" if orders_or_items == 1
      return "item" if orders_or_items == 2
      _show "Sorry, option not available"
      _show " 1 - Orders"
      _show " 2 - Items"
    end
  end

  def _show_main_menu_for(order_or_item)
    _show "-------------"
    _show "#{order_or_item.upcase} MANAGER"
    _show "-------------"

    selected = _main_menu_options_for(order_or_item)
    _execute_order_option(selected) if order_or_item == "order"
    _execute_item_option(selected) if order_or_item == "item"
  end

  def _main_menu_options_for(order_or_item)
    _show "What would you like to do?"
    _show " 1 - see all #{order_or_item}s"
    _show " 2 - find an #{order_or_item}"
    _show " 3 - create a new #{order_or_item}" 
    _show " 4 - update an #{order_or_item}"
    _show " 5 - delete an #{order_or_item}"
    _show
    _show " 9 - switch manager"
    _prompt.to_i
  end

  # ---------------------
  # SHARED METHODS
  # ---------------------
  def _show(message = "")
    @io.puts message
  end

  def _prompt(message = "")
    @io.puts message
    return @io.gets.chomp
  end

  # this method is used once by both 
  # item and order manager
  # in UPDATE METHOD CONTEXT
  def _attribute_selected 
    while true
      input = _prompt.to_i
      is_valid = input.positive? && input <= 4

      return input if is_valid

      _show("Sorry, choice not available. Try again.")
    end
  end

  # this method is used once by both 
  # item and order manager
  # in MAIN OPTION PROCESS
  def _wrong_input_process_for(user_choice)
    _show "Sorry, option not available. Try again."
    _show_main_menu_for(user_choice)
  end

  def _add_s_if_plural(array)
    length = array.length
    return length > 1 ? "s" : ""
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
