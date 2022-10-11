require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/order'

class Application
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    show "Welcome to the shop management program!"
    show "What do you want to do?"
    show "  1. List all shop items"
    show "  2. Create a new item"
    show "  3. List all orders"
    show "  4. Create a new order"
    show "  5. Find a customers full order by customers name"
    show "  6. Find all orders including a specific item"
    choice = prompt "Enter your choice: "
    if choice == "1"
      show "All Items in stock: "
      list_items
    elsif choice == "2"
      add_item
      show "Item successfully added!"
      show "All Items in stock: "
      list_items
    end
  end

  private

  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    @io.gets.chomp
  end

  def list_items
    items = @item_repository.all
    items.each_with_index do |item, i|
      show "  ##{i+1} #{item.name.capitalize} - Unit Price: £#{item.unit_price} - Quantity: #{item.quantity}"
    end
  end

  def add_item
    name = prompt "Enter the name of the item you wish to add: "
    unit_price = prompt  "Enter the unit price of the item you wish to add: "
    quantity = prompt  "Enter the quantity of the item you wish to add: "
    item = Item.new
    item.name = name
    item.unit_price = unit_price
    item.quantity = quantity
    @item_repository.create(item)
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
