require_relative './lib/item_repository'
require_relative './lib/item'
require_relative './lib/order_repository'
require_relative './lib/order'
require_relative './lib/database_connection'



class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @i_repo = item_repository
    @o_repo = order_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    clear()
    show "Welcome to the shop management program!"
    show " "
    show "What would you like to do?"
    show "1 - List all shop items"
    show "2 - Create a new item"
    show "3 - List all orders"
    show "4 - Create a new order"
    show " "
    choice = prompt "Enter your choice: "
    show "[ENTER]"
    show " "
    if choice == '1'
      get_items
    elsif choice == '2'
      create_item
    elsif choice == '3'
      get_orders
    elsif choice == '4'
      create_order
    end

  end

  def clear
    @io.system("clear")
  end

  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    return @io.gets.chomp
  end

  def get_items
    out_text = []
    show "Here is the list of all shop items:"
    items = @i_repo.all
    orders = @o_repo.all
    items.each do |item|
      out_text << "* #{item.id} - #{item.name} - £#{item.price} - #{item.quantity} in stock"
      people = []
      item.orders.each do |id|
        order = orders.select{|element| element.id == id}
        people << order[0].customer_name
      end
      if people.length == 0
        out_text << "This has not been ordered by anyone"
      elsif people.length == 1
        out_text << "Ordered by #{people[0]}"
      elsif people.length == 2
        out_text << "Ordered by #{people[0]} and #{people[1]}"
      else
        text = "Ordered by "
        (0...people.length).each do |i|
          text += "#{people[i]}"
          if i < (people.length - 2)
            text += ", "
          elsif i < (people.length - 1)
            text += " and "
          end
        end
        out_text << text
      end

    end
    show out_text.join("\n")
  end

  def get_orders
    out_text = []
    total = 0
    show "Here is the list of the shops orders:"
    items = @i_repo.all
    orders = @o_repo.all
    orders.each do |order|
      out_text << "* #{order.id} - Ordered by #{order.customer_name} on #{order.date}"
      out_text << "Items:"
      order_items = []
      order.items.each do |id|
        item = items.select{|element| element.id == id}
        order_items << item[0]
      end
      order_items.each do |item|
        out_text << "   #{item.name} - £#{item.price}"
        total += item.price.to_f
      end
      total = (total * 100).to_i
      out_text << "       Total due: £#{total / 100}.#{total % 100}"
      out_text << " "
      total = 0
    end
    out_text.pop
    show out_text.join("\n")
  end

  def create_item
    show "Creating an item:"
    name = prompt("Enter the items name: ")
    price = prompt("Enter the items price: ").to_f
    quantity = prompt("Enter the number of items in stock: ").to_i
    item = Item.new
    item.name = name
    item.price = price
    item.quantity = quantity
    @i_repo.create(item)
    show " "
    show "Item created"
  end

  def create_order
    show "Creating an order:"
    customer_name = prompt("Enter your name: ")
    date = prompt("Enter the date: ")
    items = []
    items << prompt("Enter the item number: ")
    while items.last != ""
      items << prompt("Enter the item number: ")
    end
    items.pop
    order = Order.new
    order.customer_name = customer_name
    order.date = date
    order.items = items
    @o_repo.create(order)
    show " "
    show "Order created"
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