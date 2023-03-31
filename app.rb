require_relative 'lib/database_connection'
require_relative 'lib/item_repository.rb'
require_relative 'lib/customer_repository.rb'
require_relative 'lib/order_repository.rb'


class Application

  def initialize(database_name, io, customer_repository, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @customer_repository = customer_repository
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def user_input_validate(input)
    [1,2,3,4,5,6,9].include?(input.to_i) ? input.to_i : false
  end


  def run
    show "Welcome to shop manager"
    user_choice = ask_for_choice
    loop do
      break if user_input_validate(user_choice)
      user_choice = prompt "Invalid input, please choose from list."
    end
    apply_selection(user_choice)
  end

  ### IO Methods ###

  def ask_for_choice
    show "What would you like to do? Choose one from below"
    show "1 to list all items with their prices."
    show "2 to list all items with their stock quantities"
    show "3 to list all orders made to this day"
    show "4 to list all orders made by a specific customer"
    show "5 to create a new item"
    show "6 to create a new order"
    show "9 to exit program"
    return @io.gets.chomp
  end

  def apply_selection(choice)
    case choice
      when 1
        puts "hehe"
    end
  end
  


  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    return @io.gets.chomp
  end

end


if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    CustomerRepository.new,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end