require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/order'
require_relative './lib/items_orders_repository'
require_relative './lib/items_orders'

class Application
  def initialize(database_name, io, item_repository, order_repository, items_orders_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
    @items_orders_repository = items_orders_repository
  end

  def run
    show "Welcome to the shop management program!"
    show "What do you want to do?"
    show "  1. List all shop items"
    show "  2. Create a new item"
    show "  3. Restock item"
    show "  4. List all orders"
    show "  5. Create a new order"
    show "  6. Find a customers full order by customers name"
    show "  7. Find all orders including a specific item"
    choice = prompt "Enter your choice: "
    if choice == "1"
      show "All Items in stock: "
      list_items
    elsif choice == "2"
      add_item
      show "Item successfully added!"
      show "All Items in stock: "
      list_items
    elsif choice == "4"
      show "All Orders: "
      list_orders
    elsif choice == "5"
      add_order
      show "Order successfully added!"
      show "All Orders: "
      list_orders
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

  def list_orders
    orders = @order_repository.all
    orders.each_with_index do |order, i|
      show "  Order ##{i+1} - Customer Name: #{order.customer_name} - Order Date: #{order.order_date}"
    end
  end

  def add_order
    show "Add an order: "
    customer_name = prompt "Enter the customers name: "
    order = Order.new
    order.customer_name = customer_name
    order.order_date = Time.new.to_s.split(" ")[0]
    @order_repository.create(order)
    new_order = @order_repository.find(customer_name)
    show "Here are items we have in stock: "
    list_items
    item_name = prompt "What item would you like to add: "
    add_item_to_order(item_name, new_order)
    ans = prompt "Would you like to add anything else? [Yes/No]"
    while ans == "Yes" || ans == "yes"
      new_item_name = prompt "What item would you like to add: "
      add_item_to_order(new_item_name, new_order)
      ans = prompt "Would you like to add anything else? [Yes/No]"
    end
  end

  def add_item_to_order(item_name, order)
    item = @item_repository.find(item_name)
    items_orders = ItemsOrders.new
    items_orders.item_id = item.id
    items_orders.order_id = order.id
    @items_orders_repository.create(items_orders)
    item_quantity_change(item)
  end

  def item_quantity_change(item)
    if item.quantity == "1"
      @item_repository.delete(item.id)
    else
      new_quantity = (item.quantity.to_i - 1).to_s
      item.quantity = new_quantity
      @item_repository.update_quantity(item)
    end
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
    OrderRepository.new,
    ItemsOrdersRepository.new
  )
  app.run
end
