require_relative './lib/item_repository'
require_relative './lib/order_repository'
require_relative './lib/database_connection'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name) 
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    show("\nWelcome to the shop management program!\n\n")
    choice = choice_prompt
    
    case choice
      when '1'
      # TODO: List all shop items
        p "Choice 1"
      when '2'
      # TODO: Create a new item
        p "Choice 2"
      when '3'
      # TODO: List all orders
        p "Choice 3"
      when '4'
      # TODO: Create a new order
        p "Choice 4"
      when 'q'
        show("\nGoodbye!")
      else
        p "Please select a valid option"
    end
    # show(choice)
  end
  
  private
  
  def show(message)
    @io.puts(message)
  end
  
  def prompt(message)
    @io.print(message)
    return @io.gets.chomp
  end
  
  def choice_prompt
    show("What do you want to do?")
    show("  1 = list all shop items")
    show("  2 = create a new item")
    show("  3 = list all orders")
    show("  4 = create a new order")
    show("  q = quit\n\n")
    choice = prompt("Your choice: ")
    return choice
  end
  
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
