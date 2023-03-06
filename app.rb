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
    user_choice = _order_or_item? # will return 'order' or 'item'
    _show_main_menu_for(user_choice)
  end

  private 

  def _order_or_item?
    while true
      orders_or_items = _prompt.to_i # will return 1 or 2
      return "order" if orders_or_items == 1
      return "item" if orders_or_items == 2
      _show "Sorry, option not available"
      _show " 1 - Orders"
      _show " 2 - Items"
    end
  end

  def _show_main_menu_for(user_choice) # Argument is either the string 'order' or 'item'
    _show "-------------"
    _show "#{user_choice.upcase} MANAGER"
    _show "-------------"

    selected = _prompt_options_for(user_choice) # an integer
    _execute_order_process(selected) if user_choice == "order"
    _execute_item_process(selected) if user_choice == "item"
  end

  def _prompt_options_for(user_choice) # Argument is either the string 'order' or 'item'
    _show "What would you like to do?"
    _show " 1 - see all #{user_choice}s"     # 
    _show " 2 - find an #{user_choice}"      # 
    _show " 3 - create a new #{user_choice}" # either 'order' or 'item'
    _show " 4 - update an #{user_choice}"    # 
    _show " 5 - delete an #{user_choice}"    # 
    _show
    _show " 9 - switch manager"
    _show " 0 - exit program"
    _prompt.to_i # returns an integer
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
  # item manager at line 137 
  # and order manager at line 110
  def _get_user_input
    while true
      input = _prompt.to_i
      is_valid = input.positive? && input <= 4
      return input if is_valid
      _show("Sorry, choice not available. Try again.")
    end
  end

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
