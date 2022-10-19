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
    
    while true
    
      choice = choice_prompt
      
      case choice
        when '1'
          list_all_items
        
        when '2'
          add_new_item_prompt
        
        when '3'
          list_all_orders
          
        when '4'
        # TODO: Create a new order
          p "Choice 4"
        when 'q'
          show("\nGoodbye!")
          break
        else
          show("\n[!] Please select a valid option\n\n")
      end
    end
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
  
  def list_all_items
    all_items = @item_repository.all
    output = all_items.map do |item|
      "##{item.id} #{item.item} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    end.join("\n")
    
    show("\nHere\'s a list of all shop items:\n\n")
    show(output)
    show("\n\n")
  end
  
  def add_new_item_prompt
    show("\nPlease provide details for the new item\n\n")
    item = prompt("Item name: ")
    unit_price = prompt("Unit price: ")
    quantity = prompt("Quantity: ")
    
    new_item = Item.new
    new_item.item = item
    new_item.unit_price = unit_price.to_f
    new_item.quantity = quantity.to_i
    
    @item_repository.create(new_item)
    
    show("\n[+] New item created")
  end
  
  def list_all_orders
  
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
