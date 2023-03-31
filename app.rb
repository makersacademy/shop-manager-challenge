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

  def run
    show "Welcome to shop manager"
    ## Run method is kept as light as possible to be able to test individual 
    ## methods without having to go through terminal to test them
    loop do
      user_choice = ask_for_choice
      loop do
        break if user_input_validated(user_choice)
        user_choice = prompt "Invalid input, please try again."
      end
      apply_selection(user_input_validated(user_choice))
    end
  end

  def apply_selection(choice)
    case choice
      when 1
        print_neat(@item_repository.price_list)
      when 2
        print_neat(@item_repository.inventory_stock_list)
      when 3
        print_neat(@order_repository.order_list)
      when 4
        customer_name = prompt "What is the customer name?"
        if @customer_repository.retrieve_customer_by_name(customer_name) 
          print_neat(@customer_repository.list_of_items_ordered_by_customer(customer_name))
        else
          show "Sorry, no such customer exists."
        end
      when 5
        @item_repository.add_item(ask_for_item_parameters_to_insert)
        show "Item added successfully, returning to main menu."
      when 6
        parameters = {item_id: ask_for_item_information, customer_id: ask_for_customer_information}
        @order_repository.add_order(parameters)
        show "Order added successfully, returning to main menu."
      when 9
        exit
    end
  end

  ### <--- UI METHODS --- > ###
  ## These methods handle the terminal UI interface
  ## They print out messages / handle user inputs
  ## They are tested separate to the main run method to prevent
  ## integration tests getting too repetitive with terminal output expectations

  def ask_for_choice
    show ""
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

  def print_neat(input)
    input.each {|row| show(row)}
  end

  ### <--- VALIDATOR METHODS --- > ###
  ## These methods receive input from users and make sure they are valid to prevent errors when program runs

  def ask_for_customer_information
    customer_name = prompt "What is the customer name?"
    customer_id = @customer_repository.retrieve_customer_by_name(customer_name)
    unless customer_id
      show "Looks like this customer has not shopped here before. Creating new customer with the name."
      @customer_repository.add_customer(customer_name)
      customer_id = @customer_repository.retrieve_customer_by_name(customer_name)
    end
    return customer_id
  end

  def ask_for_item_information
    item_name = prompt "What would you like to order?"
    item_id = @item_repository.retrieve_item_id_by_name(item_name)
    loop do
      break if item_id
      item_name = prompt "That item has either run out or does not exist. Please try again."
      item_id = @item_repository.retrieve_item_id_by_name(item_name)
    end
    return item_id
  end

  def ask_for_item_parameters_to_insert
    item_name = ""
    loop do
      item_name = prompt "What is the item name?"
      break unless @item_repository.retrieve_item_id_by_name(item_name)
      show "Item with the same name already exists!"
    end
    show "What is the item price?"
    item_price = integer_validator
    show "How many items do you have in stock?"
    item_quantity = integer_validator
    return {name: item_name, unit_price: item_price, quantity: item_quantity}
  end

  def user_input_validated(input)
    [1,2,3,4,5,6,9].include?(input.to_i) ? input.to_i : false
  end

  def integer_validator
    begin
      value = Integer(gets.chomp)
    rescue
      show "Please enter an integer number:"
      retry
    end
    return value
  end

  ### <--- HELPER METHODS --- > ###
  ## These methods help prevent test errors that might arise from forgetting the @io before puts in the code
  ## Lets face it, we've all been there :)

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