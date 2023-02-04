require_relative 'lib/database_connection'
require_relative 'lib/item_repository'
require_relative 'lib/order_repository'

class Application

# Perform a SQL query on the database and get the result set.
  def initialize(shop_manager_test, terminal, item_repository, order_repository)
    DatabaseConnection.connect('shop_manager')
    @terminal = terminal
    @item_repository = item_repository
    @item_repository = item_repository
  end

  def run
 
  end

  def list_items 
    @terminal.puts "Here is the list of items:"
    items = @item_repository.all  
     count = 1
       items.each do |record|
     @terminal.puts "* #{count} #{record.name}"
      count += 1
      end
  end 

  def create_item
  new_item = Item.new

  @terminal.puts "Enter item ID"
    new_item.id = @terminal.gets.chomp.to_i
    @terminal.puts "Enter the name of item"
    new_item.name = @terminal.gets.chomp
    @terminal.puts "Enter the price of the item(in a whole number)"
    new_item.price =  @terminal.gets.chomp.to_i
    @terminal.puts "Enter item quantity"
    new_item.quantity = @terminal.gets.chomp.to_i
  
    @item_repository.create(new_item)
    @terminal.puts "New item added"

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
end